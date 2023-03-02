defmodule Cards do
  @moduledoc """
  Provides a method for creating and handling deck of Cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  Create deck
  - returns a list of strings representing a deck of playing cards

  ## Examples

      iex> Cards.create_deck()
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
      "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
  """
  @spec create_deck :: [<<_::24, _::_*16>>, ...]
  def create_deck do
    values = ["Ace","Two","Three","Four","Five"]
    suits = ["Spades","Clubs","Hearts","Diamonds"]

      # for suit <- suits, value <- values do
      #   "#{value} of #{suit}"
      # end
      for suit <- suits, value <- values, do: "#{value} of #{suit}"
  end

  # def shuffle(deck) do
  #   Enum.shuffle(deck)
  # end

  # def shuffle(deck), [do: Enum.shuffle(deck)]
  def shuffle(deck), [{:do, Enum.shuffle(deck)}]

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck,hand), [do: Enum.member?(deck,hand)]

  @doc """
  Divides a deck into a hand and the remainder of the deck. The `hand_size`
  argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand,_deck} = Cards.deal(deck,4)
      iex(12)> hand
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades"]
  """
  def deal(deck, hand_size), [{:do, Enum.split(deck, hand_size)}]

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    create_deck() |> shuffle() |> deal(hand_size)
  end
end
