defmodule PlateSlateWeb.Resolvers.Menu do
  alias PlateSlate.Menu
  alias PlateSlate.Menu.Item
  alias PlateSlate.Repo

  def menu_items(_, args, _) do
    {:ok, Menu.list_items(args)}
  end

  def items_for_category(category, _, _) do
    query = Ecto.assoc(category, :items)
    {:ok, PlateSlate.Repo.all(query)}
  end

  def search(_, %{matching: term}, _) do
    {:ok, Menu.search(term)}
  end

  def create_item(_, %{input: params}, _) do
    case Menu.create_item(params) do
      {:error, changeset} ->
        {:ok, %{errors: transform_errors(changeset)}}
      {:ok, menu_item} ->
        {:ok, %{menu_item: menu_item}}
    end
  end
  # connected with logic
  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn
      {key, value} ->
        %{key: key, message: value}
    end)
  end
  @spec format_error(Ecto.Changeset.error) :: String.t
  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end

  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end
  # query Search($term: String!) {
  #   search(matching: $term) {
  #   ... on MenuItem {
  #   name
  #   }
  #   ... on Category {
  #   name
  #   items {
  #   name
  #   }
  #   }
  #     __typename
  #   }
  #   }

end
