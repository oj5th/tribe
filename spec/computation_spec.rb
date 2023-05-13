require './computation'

describe Computation, "#compute_and_print" do
  context "compute input value based bundle and code" do
    before do
      @video_bundle = [9, 5, 3]
      @audio_bundle = [9, 6, 3]
      @image_bundle = [10, 5]
    end

    describe "IMG" do
      context "when divisible on defined bundles" do
        it "returns divided value based on bundles" do
          expect do
            Computation.new(@image_bundle, 10, "IMG").compute_and_print
          end.to output("10 IMG $800\n\t1 x 10 $800\n").to_stdout
        end
      end

      context "when NOT divisible on defined bundles" do
        it "returns the input value and provide offered value higher and closest to the input" do
          expect do
            Computation.new(@image_bundle, 14, "IMG").compute_and_print
          end.to output("Order count: 14. Offered bundle 15.\n15 IMG $1250\n\t1 x 10 $800\n\t1 x 5 $450\n").to_stdout
        end
      end
    end

    describe "FLAC" do
      context "when divisible on defined bundles" do
        it "returns divided value based on bundles" do
          expect do
            Computation.new(@audio_bundle, 15, "FLAC").compute_and_print
          end.to output("15 FLAC $1957.5\n\t1 x 9 $1147.5\n\t1 x 6 $810\n").to_stdout
        end
      end

      context "when NOT divisible on defined bundles" do
        it "returns the input value and provide offered value higher and closest to the input" do
          expect do
            Computation.new(@audio_bundle, 22, "FLAC").compute_and_print
          end.to output("Order count: 22. Offered bundle 24.\n24 FLAC $3105.0\n\t2 x 9 $2295.0\n\t1 x 6 $810\n").to_stdout
        end
      end
    end

    describe "VID" do
      context "when divisible on defined bundles" do
        it "returns divided value based on bundles" do
          expect do
            Computation.new(@video_bundle, 13, "VID").compute_and_print
          end.to output("13 VID $2370\n\t2 x 5 $1800\n\t1 x 3 $570\n").to_stdout
        end
      end

      context "when NOT divisible on defined bundles" do
        it "returns the input value and provide offered value higher and closest to the input" do
          expect do
            Computation.new(@audio_bundle, 34, "VID").compute_and_print
          end.to output("Order count: 34. Offered bundle 36.\n36 VID $1530\n\t4 x 9 $6120\n").to_stdout
        end
      end
    end
  end
end
