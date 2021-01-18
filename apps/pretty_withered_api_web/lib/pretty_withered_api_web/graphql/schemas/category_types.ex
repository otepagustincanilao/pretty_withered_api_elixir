defmodule PrettyWitheredApiWeb.Graphql.Schemas.CategoryTypes do
  use Absinthe.Schema.Notation

  @moduledoc false

  alias PrettyWitheredApi.Contexts.UtilityContext
  alias PrettyWitheredApiWeb.Graphql.Resolvers.Category

  @desc "Category detail"
  object :category do
    field(:code, :string, description: "Category code")
    field(:name, :string, description: "Category name")
    field(:description, :string, description: "Category description")
    field(:slug, :string, description: "Category slug")
  end

  @desc "List of category and total number of category"
  object :categories do
    field(:total_number, :integer, description: "Total number of categories")
    field(:categories, list_of(:category), description: "List of category")
  end

  @desc "Category Queries"
  object :category_queries do
    @desc "Return list of Category"
    field :categories, :categories do
      @desc """
      - Search value
        - Optional
        - Possible error messages
          - No category matched your search
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
          - Sort by is invalid: '{?}'. Allowed values. [code, name, description, slug]
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
      resolve(UtilityContext.handle_errors(&Category.get_categories/3))
    end

    @desc "Return category details"
    field :category, :category do
      @desc """
      - Category code
        - Required
        - Possible error messages
          - Enter code
          - Category does not exist
      """
      arg(:code, non_null(:string))

      resolve(UtilityContext.handle_errors(&Category.get_brand/3))
    end
  end

   ####################################### Start of Mutations ###################################################

  @desc "Category Mutations"
  object :category_mutations do
    @desc "Create Category"
    field :create_category, :category do
      #################################
      @desc """
      - Category Code
        - Required
        - Possible error messages
          - Enter code
          - Category Code only accepts alphanumeric value with or without ('-') (',') ('_') 
          - Category Code only accepts alphanumeric up to 60 characters
          - Category code already exist
      """
      arg(:code, non_null(:string))
      ##################################
      @desc """
      - Category Name
        - Required
        - Possible error messages
          - Enter name
          - Name only accepts alphanumeric up to 150 characters
      """
      arg(:name, non_null(:string))
      ##################################
      @desc """
      - Category Description
        - Optional
      """
      arg(:description, :string)
     ####################################
      @desc """
      - Category Slug
        - Optional
        - Slug is a human-readable, unique identifier, 
          used to identify a resource instead of a less human-readable 
          identifier like an id.
      """
      arg(:slug, :string)
     ####################################

      resolve UtilityContext.handle_errors(&Category.create/3)
    end

  end

  ####################################### End of Mutations ###################################################

end
