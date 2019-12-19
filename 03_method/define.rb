# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること
class A1
  define_method("//") do
    "//"
  end
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと
class A2
  def initialize(args)
    args.each do |arg|
      method_name = "hoge_#{arg}"
      self.define_singleton_method(method_name) do |n|
        return dev_team if n.nil?

        method_name * n
      end
    end
  end

  def dev_team
    "SmartHR Dev Team"
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること
module OriginalAccessor
  def self.included(klass)
    klass.extend(ClassMethod)
  end

  module ClassMethod
    def my_attr_accessor(arg)
      define_method(arg) do
        instance_variable_get("@#{arg}")
      end

      define_method("#{arg}=") do |n|
        if [true, false].include?(n)
          define_singleton_method("#{arg}?") do
            !!send(arg)
          end
        end
        instance_variable_set("@#{arg}", n)
      end
    end
  end
end
