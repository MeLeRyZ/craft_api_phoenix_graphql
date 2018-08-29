defmodule PlateSlateWeb.Schema.Query.MenuItemsTest do
    use PlateSlateWeb.ConnCase, async: true

    setup do
        PlateSlate.Seeds.run()
    end

    @query """
    {
        MenuItems{
            name
        }
    }
    """
    test "MenuItems field returns menu items" do
        conn = build_conn()
        conn = get conn, "/api", query: @query

        assert json_response(conn, 200) == %{
            "data" => %{
                "MenuItems" => [
                    %{"name" => "Reuben"},
                    %{"name" => "Croque Monsieur"},
                    %{"name" => "Muffuletta"},
                    %{"name" => "Bánh mì"},
                    %{"name" => "Vada Pav"},
                    %{"name" => "French Fries"},
                    %{"name" => "Papadum"},
                    %{"name" => "Pasta Salad"},
                    %{"name" => "Water"},
                    %{"name" => "Soft Drink"},
                    %{"name" => "Lemonade"},
                    %{"name" => "Masala Chai"},
                    %{"name" => "Vanilla Milkshake"},
                    %{"name" => "Chocolate Milkshake"}
                ]
            }
        }
    end

end
