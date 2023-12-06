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

public class Shots {

    public static class ShotsMapper extends Mapper<Object, Text, Text, IntWritable> {
        private final static IntWritable one = new IntWritable(1);
        private Text team = new Text();

        @Override
        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
            StringTokenizer tokenizer = new StringTokenizer(value.toString(), ",");

            try {
                // Skip the first field
                tokenizer.nextToken();

                // Extract home team and away team
                String homeTeam = tokenizer.nextToken().trim();
                String awayTeam = tokenizer.nextToken().trim();

                // Skip 7 fields
                for (int i = 0; i < 7; i++) {
                    tokenizer.nextToken();
                }

                int homeShots = Integer.parseInt(tokenizer.nextToken().trim());
                int awayShots = Integer.parseInt(tokenizer.nextToken().trim());
                
                team.set(homeTeam);
                context.write(team, new IntWritable(homeShots));
                
                team.set(awayTeam);
                context.write(team, new IntWritable(awayShots));

            } catch (Exception e) {
                System.err.println("Error processing record: " + value);
                e.printStackTrace();
            }
        }
    }

    public static class ShotsReducer extends Reducer<Text, IntWritable, Text, FloatWritable> {
        private FloatWritable result = new FloatWritable();
        private final int totalGames = 38;

        @Override
        public void reduce(Text key, Iterable<IntWritable> values, Context context)
                throws IOException, InterruptedException {
            int total = 0;

            for (IntWritable val : values) {
                total += val.get();
            }

            float averageShots = (float) total / totalGames;

            result.set(averageShots);
            context.write(new Text(key), result);
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "average shots per team");
        job.setJarByClass(Shots.class);
        job.setMapperClass(ShotsMapper.class);
        job.setReducerClass(ShotsReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}


