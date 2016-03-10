require_relative 'day7'

describe Circuit do
  let(:circuit) { Circuit.new }
  describe "build" do
    it "correctly sets signals on all wires" do
      input = <<-INPUT
123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i
      INPUT

      expected = {
        "d" =>  72,
        "e" =>  507,
        "f" =>  492,
        "g" =>  114,
        "h" =>  65412,
        "i" =>  65079,
        "x" =>  123,
        "y" =>  456,
      }
      circuit.build(input)

      expect(circuit.wires).to eq expected
    end
  end

  describe "parse" do
    it "parses wire" do
      circuit.parse("123 -> x")

      expect(circuit.wires["x"]).to eq 123
    end

    it "parses AND" do
      circuit.parse("123 -> x")
      circuit.parse("456 -> y")
      circuit.parse("x AND y -> d")

      expect(circuit.wires["d"]).to eq 72
    end

    it "parses OR" do
      circuit.parse("123 -> x")
      circuit.parse("456 -> y")
      circuit.parse("x OR y -> e")

      expect(circuit.wires["e"]).to eq 507
    end

    it "parses LSHIFT" do
      circuit.parse("123 -> x")
      circuit.parse("x LSHIFT 2 -> f")

      expect(circuit.wires["f"]).to eq 492
    end

    it "parses RSHIFT" do
      circuit.parse("456 -> y")
      circuit.parse("y RSHIFT 2 -> g")

      expect(circuit.wires["g"]).to eq 114
    end

    it "parses NOT" do
      circuit.parse("123 -> x")
      circuit.parse("NOT x -> h")

      expect(circuit.wires["h"]).to eq 65412
    end

    describe "build2" do
      it "resolves dependencies" do
      input = <<-INPUT
x AND y -> d
x OR y -> e
123 -> x
456 -> y
      INPUT

      expected = {
        "d" =>  %w[x y],
        "e" =>  %w[x y],
        "x" =>  [],
        "y" =>  [],
      }
      circuit.build2(input)

      expect(circuit.unresolved).to eq expected
      end
    end
  end
end
