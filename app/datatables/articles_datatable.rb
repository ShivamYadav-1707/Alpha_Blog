class ArticlesDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      date: { source: "Article.created_at", cond: :like, searchable: true, orderable: true },
      title:  { source: "Article.title",  cond: :like, searchable: true, nulls_last: true },
      description: { source: "Article.description", cond: :like, searchable: true},
    }
  end


  def data
    records.map do |record|
      {
        date: record.date,
        title: record.title,
        description: record.description
    }
    end
  end

  def get_raw_records
    Article.all
  end

end
