defmodule PlateSlateWeb.Resolvers.Menu do
  alias PlateSlate.Menu

# """
# In general, a resolver’s job is to mediate between the input that a user sends to our
# GraphQL API and the business logic that needs to be called to service their request. As
# your schema gets more complex, you’ll be glad you made space in the overall architecture
# of your application to keep your resolver and domain business logic separate.
# """

  def menu_items(_, args, _) do
    {:ok, Menu.list_items(args)}
  end
end
