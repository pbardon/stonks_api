json.partial! "searches/search", search: @search

if @search.company
    json.company do
        json.partial! 'companies/company', company: @search.company
    end
end