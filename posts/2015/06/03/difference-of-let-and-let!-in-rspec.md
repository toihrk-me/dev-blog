# [RSpecのletとlet!](/2015/06/03/difference-of-let-and-let!-in-rspec.html)

RSpecの`let`は[rspec/rspec-core](https://github.com/rspec/rspec-core)の上で[lib/rspec/core/memoized_helpers.rb](https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/memoized_helpers.rb#L284-L297)内に定義されている。同様に`let!`も同ファイルの[352行目あたり](https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/memoized_helpers.rb#L352-L355)から定義されている。

2つのメソッドの違いは、Cucumberのテストの[features/helper_methods/let.feature](https://github.com/rspec/rspec-core/blob/master/features/helper_methods/let.feature)が参考になった。

>   Use `let` to define a memoized helper method. The value will be cached across
  multiple calls in the same example but not across examples.

>  Note that `let` is lazy-evaluated: it is not evaluated until the first time
  the method it defines is invoked. You can use `let!` to force the method's
  invocation before each example.

英語の理解が乏しいので単語とかを拾って読む。

`let`はメモ化を行い、同一のテストであれば同じオブジェクトを使い回せ、他のテストではまた評価が行われる。

`let`は遅延評価される。最初にメソッド呼び出されるまで定義がされない。即座に評価する必要があるならば`let!`を使う必要がある。

不安だから調べてみたがだいたいこんな感じっぽい。

`memoized_helpers.rb`内でコメントアウトされている例を見ると納得する。

```ruby
class Thing
  def self.count
    @count ||= 0
  end

  def self.count=(val)
    @count += val
  end

  def self.reset_count
    @count = 0
  end

  def initialize
    self.class.count += 1
  end
end

describe Thing do
  after(:example) { Thing.reset_count }

  context "using let" do
    let(:thing) { Thing.new }

    it "is not invoked implicitly" do
      Thing.count.should eq(0)
    end

    it "can be invoked explicitly" do
      thing
      Thing.count.should eq(1)
    end
  end

  context "using let!" do
    let!(:thing) { Thing.new }

    it "is invoked implicitly" do
      Thing.count.should eq(1)
    end

    it "returns memoized version on first invocation" do
      thing
      Thing.count.should eq(1)
    end
  end
end
```

`let`であると遅延評価されるため呼び出しがないとクラスメソッドの`count`は`0`のままだが、`let!`を使うと即座に評価されるため`count`は`1`になる。
