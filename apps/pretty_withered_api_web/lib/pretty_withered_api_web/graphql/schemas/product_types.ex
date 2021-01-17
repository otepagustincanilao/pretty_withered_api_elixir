defmodule PrettyWitheredApiWeb.Graphql.Schemas.ProductTypes do
  use Absinthe.Schema.Notation

  @moduledoc false

  alias PrettyWitheredApi.Contexts.UtilityContext
  alias PrettyWitheredApiWeb.Graphql.Resolvers.Product

  @desc "Product detail"
  object :product do
    field(:id, :string, description: "Product id")
    field(:brand_code, :string, description: "Product brand code")
    field(:collection_code, :string, description: "Product collection code")
    field(:model, :string, description: "Product model no.")
    field(:name, :string, description: "Product name")
    field(:description, :string, description: "Product description")
    field(:taggings, :string, description: "Product Taggings")
    field(:current_price, :string, description: "Product current price")
    field(:original_price, :string, description: "Product original price")
    field(:sku, :string, description: "SKU of a product")
    field(:stock, :integer, description: "Product Stock")
    field(:is_featured_item, :string, description: "Boolean")
  end

  @desc "List of products and total number of products"
  object :products do
    field(:total_number, :integer, description: "Total number of products")
    field(:products, list_of(:product), description: "List of products")
  end

  @desc "Product Queries"
  object :product_queries do
    @desc "Return list of Products"
    field :products, :products do
      @desc """
      - Search value
        - Optional
        - Possible error messages
          - No product matched your search
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
          - Sort by is invalid: '{?}'. Allowed values. [code, name, updated_at, updated_by]
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
      resolve(UtilityContext.handle_errors(&Product.get_products/3))
    end

    @desc "Return product details"
    field :product, :product do
      @desc """
      - Product code
        - Required
        - Possible error messages
          - Enter code
          - Product does not exist
      """
      arg(:code, non_null(:string))

      resolve(UtilityContext.handle_errors(&Product.get_product/3))
    end
  end

  ####################################### Start of Mutations ###################################################

  @desc "Product Mutations"
  object :product_mutations do
    @desc "Create Product"
    field :create_product, :product do
      #################################
      @desc """
      - Brand Code
        - Required
        - Possible error messages
          - Enter brand code
          - Possible error messages
            - Brand code does not exist
      """
      arg(:brand_code, non_null(:string))
      ##################################
      @desc """
      - Collection Code
        - Optional
        - Possible error messages
          - Collection code does not exist
      """
      arg(:collection_code, :string)
      ##################################
      @desc """
      - Product Name
        - Required
        - Possible error messages
          - Enter product name
          - Product name only accepts alphanumeric value with or without ('-') (',') ('_') 
      """
      arg(:name, non_null(:string))
      ##################################
      @desc """
      - Product Model no.
        - Required
        - Possible error messages
          - Enter product model
          - Product model only accepts alphanumeric value with or without ('-') (',') ('_') 
      """
      arg(:model, non_null(:string))
      ##################################
      @desc """
      - Product Description
        - Optional 
      """
      arg(:description, :string)
      ##################################
      @desc """
      - Product Category or sub-category
        - Required 
        - Possible error messages
          - Must have at least one item
          - Category{index} is not existing
      """
      arg(:categories, list_of(:string))
      ##################################
      @desc """
      - Product Taggings
        - Optional 
          - Free text taggings
      """
      arg(:taggings, list_of(:string))
      ##################################
      @desc """
      - Current Price
        - Required 
        - Possible error messages
          - Must be a decimal number
          - Must not be 0(zero)
      """
      arg(:current_price, non_null(:string))
      ##################################
      @desc """
      - Original Price
        - Required 
        - Possible error messages
          - Must be a decimal number
          - Must not be 0(zero)
      """
      arg(:original_price, non_null(:string))
      ##################################
      @desc """
      - Stock-keeping unit(SKU) of a product 
        - Optional 
        - Possible error messages
          - Product sku only accepts alphanumeric value
          - Must be unique
      """
      arg(:sku, :string)
      ##################################
      @desc """
      - Product Stock
        - Optional 
        - Possible error messages
          - Must be an integer
          - Must not be 0(zero)
      """
      arg(:stock, :integer)
      ##################################
      @desc """
      - Product featuring
        - Required
        - true means, will feature this product in store homepage
        - Possible error messages
          - Must be a boolean true or false
      """
      arg(:is_featured_item, non_null(:boolean))
      ##################################

      resolve UtilityContext.handle_errors(&Product.create/3)
    end

  end

  ####################################### End of Mutations ###################################################

end
