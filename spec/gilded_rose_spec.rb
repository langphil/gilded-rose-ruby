require './gilded_rose'

describe GildedRose do

  let(:normal) { Item.new("foo", 5, 5) }
  let(:normal_qual) { Item.new("foo", -1, 5) }
  let(:normal_two) { Item.new("foo", 5, 0) }

  let(:brie) { Item.new("Aged Brie", 5, 5) }
  let(:brie_qual) { Item.new("Aged Brie", 0, 50) }
  let(:brie_two) { Item.new("Aged Brie", 0, 0) }
  let(:brie_two_qual) { Item.new("Aged Brie", 0, 48) }

  let(:backstage_passes) { Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)}
  let(:backstage_passes_2) { Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)}
  let(:backstage_passes_3) { Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)}
  let(:backstage_passes_4) { Item.new("Backstage passes to a TAFKAL80ETC concert", 30, 10)}
  let(:backstage_passes_5) { Item.new("Backstage passes to a TAFKAL80ETC concert", 30, 50)}

  let(:sulfuras) { Item.new("Sulfuras", 0, 50) }

  let(:items) {
    [
      normal, normal_qual, normal_two, brie, brie_qual, brie_two, brie_two_qual,
      backstage_passes, backstage_passes_2, backstage_passes_3, backstage_passes_4,
      backstage_passes_5
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
          expect(normal_two.quality).to eq 0
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
        it "increases in quality by two" do
          expect(brie_two.quality).to eq 2
        end

        it "cannot have a quality higher than 50" do
          expect(brie_two_qual.quality).to eq 50
        end
      end
    end

    context "item is legendary Sulfuras item" do
      it "does not depreciate in quality" do
        expect(sulfuras.quality).to eq 50
      end
    end

    context "item is Backstage passes to a TAFKAL80ETC concert" do
      context "concert is over" do
        it "is worth nothing and has a value of 0" do
          expect(backstage_passes.quality).to eq 0
        end
      end

      context "5 days or less until concert" do
        it "increases in value by 3" do
          expect(backstage_passes_2.quality).to eq 13
        end
      end

      context "10 days or less until concert" do
        it "increases in value by 2" do
          expect(backstage_passes_3.quality).to eq 12
        end
      end

      context "more than 10 days until the concert" do
        it "increases in value by 1" do
          expect(backstage_passes_4.quality).to eq 11
        end

        it "does not increase to more than 50 quality" do
          expect(backstage_passes_5.quality).to eq 50
        end
      end
    end
  end
end
