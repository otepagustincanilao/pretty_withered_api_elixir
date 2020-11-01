defmodule PrettyWitheredApiWeb.Graphql.Schemas.BrandTypes do
  use Absinthe.Schema.Notation

  @moduledoc false

  alias PrettyWitheredApi.Contexts.UtilityContext

  @desc "Brand detail"
  object :brand do
    field(:code, :string, description: "Brand code")
    field(:name, :string, description: "Brand name")
    field(:description, :string, description: "Brand description")
  end

  @desc "List of brands and total number of brands"
  object :brands do
    field(:total_number, :integer, description: "Total number of brands")
    field(:brands, list_of(:brand), description: "List of brands")
  end

  @desc "Brand Queries"
  object :brand_queries do
    @desc "Return list of Brands"
    field :brands, :brands do
      @desc """
      - Search value
        - Optional
        - Possible error messages
          - No brand matched your search
      """
      arg(:search_value, :string)

      @desc """
      - Page number of datatable
        - Required
        - Possible error messages
          - Enter page number
          - Page number should be greater than zero
      """
      arg(:page_number, non_null(:integer))

      @desc """
      - Number of display per page
        - Required
        - Allowed values (10, 20, 50, 100)
        - Possible error messages
          - Enter display per page
          - Display per page should be greater than zero
          - Display per page is invalid: '{?}'. Allowed values [10, 20, 50, 100]
      """
      arg(:display_per_page, non_null(:integer))

      @desc """
      - Sorting of datatable based on fields displayed
        - Required
        - Allowed values
          - code
          - name
          - description
          - updated_at
          - updated_by
        - Possible error messages
          - Enter sort by
          - Sort by is invalid: '{?}'. Allowed values. [code, name, type, coverages, updated_at, updated_by]
      """
      arg(:sort_by, non_null(:string))

      @desc """
      - Ordering of datatable
        - Required
        - Allowed values (asc, desc)
        - Possible error messages
          - Enter order by
          - Order by is invalid: '{?}'. Allowed values [asc, desc]
      """
      arg(:order_by, non_null(:string))
      resolve(UtilityContext.handle_errors(&Brand.get_brands/3))
    end

    @desc "Return brand details"
    field :brand, :brand do
      @desc """
      - Brand code
        - Required
        - Possible error messages
          - Enter code
          - Brand does not exist
      """
      arg(:code, non_null(:string))

      resolve(UtilityContext.handle_errors(&Brand.get_brand/3))
    end
  end

end
