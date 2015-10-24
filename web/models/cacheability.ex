defmodule Cacheability do
  import Cache

  defmacro __using__(_) do
    quote do
      def get_cached(key, type) do
        case get_key(key, type) do
          :empty ->
            IO.puts "Raw Hit"
            cache_and_return_items
          items ->
            IO.puts "Cache Hit"
            items
        end
      end

      defp cache_and_return_items do
        []
      end

      defoverridable [cache_and_return_items: 0]
    end
  end
end
