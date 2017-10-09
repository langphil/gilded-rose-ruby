require './gilded_rose'

describe GildedRose do

  let(:normal) { Item.new("foo", 5, 5) }
  let(:normal_qual) { Item.new("foo", -1, 5) }
  let(:normal_n) { Item.new("foo", 5, 0) }

  let(:brie) { Item.new("Aged Brie", 5, 5) }
  let(:brie_qual) { Item.new("Aged Brie", 0, 50) }
  let(:brie_two) { Item.new("Aged Brie", 0, 0) }
  let(:brie_two_qual) { Item.new("Aged Brie", 0, 50) }

  let(:items) {
    [
      normal, normal_qual, normal_n, brie, brie_qual, brie_two
    ]
  }
  subject(:gilded_rose) { described_class.new(items) }

  describe "#update_quality" do

    before do
      gilded_rose.update_quality
    end

    context "item is a normal item" do
      context "sell_in date has not passed" do
        it "lowers in quality by one" do
          expect(normal.quality).to eq 4
        end

        it "lowers in sell_in by one" do
          expect(normal.sell_in).to eq 4
        end
      end

      context "sell_in has passed" do
        it "lowers in quality two points" do
          expect(normal_qual.quality).to eq 3
        end

        it "does not set quality lower than 0" do
          expect(normal_n.quality).to eq 0
        end
      end
    end

    context "item is aged brie" do
      context "sell_in date has not passed" do
        it "increases in quality by one" do
          expect(brie.quality).to eq 6
        end

        it "cannot have a quality higher than 50" do
          expect(brie_qual.quality).to eq 50
        end
      end

      context "sell_in has passed" do
        it "increases in quality by one" do
          expect(brie_two.quality).to eq 2
        end

        it "cannot have a quality higher than 50" do
          expect(brie_two_qual.quality).to eq 50
        end
      end
    end
  end
end
