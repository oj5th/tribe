require './order'

describe Order, "#run" do
  context "compute input value based bundle and code" do
    describe "complete input IMG FLAC VID" do
      context "divisible on defined bundle" do
        it "returns divided value from bundle only" do
          expect do
            Order.new("10 IMG 15 FLAC 13 VID").run
          end.to output("13 VID $2370\n\t2 x 5 $1800\n\t1 x 3 $570\n\n15 FLAC $1957.5\n\t1 x 9 $1147.5\n\t1 x 6 $810\n\n10 IMG $800\n\t1 x 10 $800\n\n").to_stdout
        end
      end

      context "NOT divisible on defined bundle" do
        it "returns divided value from bundle with suggestion bundle" do
          expect do
            Order.new("9 IMG 15 FLAC 13 VID").run
          end.to output("13 VID $2370\n\t2 x 5 $1800\n\t1 x 3 $570\n\n15 FLAC $1957.5\n\t1 x 9 $1147.5\n\t1 x 6 $810\n\nOrder count: 9. Offered bundle 10.\n10 IMG $800\n\t1 x 10 $800\n\n").to_stdout
        end
      end
    end

    describe "Two codes input" do
      context "divisible on defined bundle" do
        it "returns divided value from bundle only - input: IMG and VID" do
          expect do
            Order.new("10 IMG 13 VID").run
          end.to output("13 VID $2370\n\t2 x 5 $1800\n\t1 x 3 $570\n\n10 IMG $800\n\t1 x 10 $800\n\n").to_stdout
        end

        it "returns divided value from bundle only - input: IMG and FLAC" do
          expect do
            Order.new("10 IMG 15 FLAC").run
          end.to output("15 FLAC $1957.5\n\t1 x 9 $1147.5\n\t1 x 6 $810\n\n10 IMG $800\n\t1 x 10 $800\n\n").to_stdout
        end

        it "returns divided value from bundle only - input: FLAC and VID" do
          expect do
            Order.new("FLAC 13 VID").run
          end.to output("13 VID $2370\n\t2 x 5 $1800\n\t1 x 3 $570\n\n").to_stdout
        end
      end

      context "NOT divisible on defined bundle" do
        it "returns divided value from bundle only - input: IMG and VID" do
          expect do
            Order.new("9 IMG 13 VID").run
          end.to output("13 VID $2370\n\t2 x 5 $1800\n\t1 x 3 $570\n\nOrder count: 9. Offered bundle 10.\n10 IMG $800\n\t1 x 10 $800\n\n").to_stdout
        end

        it "returns divided value from bundle only - input: IMG and FLAC" do
          expect do
            Order.new("10 IMG 17 FLAC").run
          end.to output("Order count: 17. Offered bundle 18.\n18 FLAC $1147.5\n\t2 x 9 $2295.0\n\n10 IMG $800\n\t1 x 10 $800\n\n").to_stdout
        end

        it "returns divided value from bundle only - input: FLAC and VID" do
          expect do
            Order.new("15 FLAC 44 VID").run
          end.to output("Order count: 44. Offered bundle 45.\n45 VID $1530\n\t5 x 9 $7650\n\n15 FLAC $1957.5\n\t1 x 9 $1147.5\n\t1 x 6 $810\n\n").to_stdout
        end
      end
    end

    describe "Single codes input" do
      describe "IMG" do
        context "divisible on defined bundle" do
          it "returns divided value from bundle only" do
            expect do
              Order.new("10 IMG").run
            end.to output("10 IMG $800\n\t1 x 10 $800\n\n").to_stdout
          end
        end

        context "NOT divisible on defined bundle" do
          it "returns divided value from bundle only" do
            expect do
              Order.new("14 IMG").run
            end.to output("Order count: 14. Offered bundle 15.\n15 IMG $1250\n\t1 x 10 $800\n\t1 x 5 $450\n\n").to_stdout
          end
        end
      end

      describe "FLAC" do
        context "divisible on defined bundle" do
          it "returns divided value from bundle only" do
            expect do
              Order.new("15 FLAC").run
            end.to output("15 FLAC $1957.5\n\t1 x 9 $1147.5\n\t1 x 6 $810\n\n").to_stdout
          end
        end

        context "NOT divisible on defined bundle" do
          it "returns divided value from bundle only" do
            expect do
              Order.new("28 FLAC").run
            end.to output("Order count: 28. Offered bundle 30.\n30 FLAC $3915.0\n\t2 x 9 $2295.0\n\t2 x 6 $1620\n\n").to_stdout
          end
        end
      end

      describe "VID" do
        context "divisible on defined bundle" do
          it "returns divided value from bundle only" do
            expect do
              Order.new("16 VID").run
            end.to output("16 VID $2940\n\t2 x 5 $1800\n\t2 x 3 $1140\n\n").to_stdout
          end
        end

        context "NOT divisible on defined bundle" do
          it "returns divided value from bundle only" do
            expect do
              Order.new("22 VID").run
            end.to output("Order count: 22. Offered bundle 23.\n23 VID $3960\n\t2 x 9 $3060\n\t1 x 5 $900\n\n").to_stdout
          end
        end

        context "Input limitations" do
          it "return IMG input is out of range" do
            img_limit_input = 40
            expect do
              Order.new("50 IMG").run
            end.to output("Order out of range. Order for IMG should not greater than #{img_limit_input}.\n\n").to_stdout
          end

          it "return FLAC input is out of range" do
            flac_limit_input = 54
            expect do
              Order.new("60 FLAC").run
            end.to output("Order out of range. Order for FLAC should not greater than #{flac_limit_input}.\n\n").to_stdout
          end

          it "return VID input is out of range" do
            video_limit_input = 54
            expect do
              Order.new("100 VID").run
            end.to output("Order out of range. Order for VID should not greater than #{video_limit_input}.\n\n").to_stdout
          end
        end
      end
    end
  end
end
