class CsvsController < ApplicationController
  before_action :signed_in_user, :admin_user

  def index
    @models = []
    ActiveRecord::Base.connection.tables.each do |table|
      @models << table.capitalize.singularize.camelize.constantize rescue nil
    end
  end

  def import
    model = params[:model].constantize rescue nil
    file  = params[:file]
    if file.nil?
      flash[:error] = "Please choose file to import."
    else
      import_csv model, file
      flash[:success] = "Import completed."
    end
    redirect_to csvs_path
  end

  def export
    model = params[:model].constantize rescue nil
    if model.nil?
      redirect_to csvs_path
    else
      send_data export_csv(model), filename: "#{model.table_name}.csv"
    end
  end

  private

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def import_csv model, file
      CSV.foreach(file.path, headers: true) do |row|
        records = model.where id: row[0]
        model.create row.to_hash if records.empty?
      end
    end

    def export_csv model
      CSV.generate do |csv|
      csv << model.column_names
      model.all.each do |item|
        csv << item.attributes.values_at(*model.column_names)
      end
    end
  end
end