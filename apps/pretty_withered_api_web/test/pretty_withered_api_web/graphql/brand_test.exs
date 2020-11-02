defmodule PrettyWitheredApiWeb.Graphql.BrandTest do
  use PrettyWitheredApiWeb.ConnCase

  import PrettyWitheredApi.Factory
  # alias PrettyWitheredApi.Repo
  # alias PrettyWitheredApi.Schemas.Brand

  @moduledoc false

  setup do
    insert(:brand, code: "NIKEPH")

    {:ok, %{}}
  end

  describe "Fetching of brands" do
    test "get list of brands" do
      query = """
        query{
          brands(
            searchValue: "",
            pageNumber: 1,
            displayPerPage: 10,
            sortBy: "name",
            orderBy: "asc"
        ){
          totalNumber,
          brands{
            code,
            name,
            description
          }
        }
      }
      """

      conn =
        post(
          Plug.Conn.put_req_header(build_conn(), "content-type", "plain/text"),
          "api/v1/graphql",
          query
        )

      raise json_response(conn, 200)

    end
  end
  ########################################## start of SEARCH benefit test ###########################################
  
end
