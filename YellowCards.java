import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class YellowCards {

    public static class YellowCardsMapper extends Mapper<Object, Text, Text, IntWritable> {
        private final static IntWritable one = new IntWritable(1);
        private Text team = new Text();

        @Override
        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
            StringTokenizer tokenizer = new StringTokenizer(value.toString(), ",");

            try {
                
                tokenizer.nextToken();

                String homeTeam = tokenizer.nextToken().trim();
                String awayTeam = tokenizer.nextToken().trim();

                for (int i = 0; i < 15; i++) {
                    tokenizer.nextToken();
                }

                int homeYellowCards = Integer.parseInt(tokenizer.nextToken().trim());
                int awayYellowCards = Integer.parseInt(tokenizer.nextToken().trim());

                team.set(homeTeam);
                context.write(team, new IntWritable(homeYellowCards));

                team.set(awayTeam);
                context.write(team, new IntWritable(awayYellowCards));

            } catch (Exception e) {
                System.err.println("Error processing record: " + value);
                e.printStackTrace();
            }
        }
    }

    public static class YellowCardsReducer extends Reducer<Text, IntWritable, Text, FloatWritable> {
        private FloatWritable result = new FloatWritable();
        private final int totalGames = 38;

        @Override
        public void reduce(Text key, Iterable<IntWritable> values, Context context)
                throws IOException, InterruptedException {
            int total = 0;

            for (IntWritable val : values) {
                total += val.get();
            }

            float averageYellowCards = (float) total / totalGames;

            result.set(averageYellowCards);
            context.write(new Text(key), result);
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "average yellow cards per team");
        job.setJarByClass(YellowCards.class);
        job.setMapperClass(YellowCardsMapper.class);
        job.setReducerClass(YellowCardsReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}

