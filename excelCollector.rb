
require 'rubyXL'
composite_excel_files =  Dir.glob('**/*.xlsx')
result_excel_file_name = 'Services.xlsx'

def findPathIndex(worksheet,header)
  row = worksheet[2]
   row && row.cells.each { |cell|
     val = cell && cell.value
     if val ==header
     return Integer(cell.column)
     end
   }
    return 5
end


puts composite_excel_files.size
index=1
workbook =  RubyXL::Parser.parse(result_excel_file_name)
new_sheet=workbook.worksheets[0]
composite_excel_files.each do |path|
    composite_name = path.split('/')[-2]
    operation_name = path.split('/')[-1].split('Interface Specification Document v1.').first
    puts path
	book = RubyXL::Parser.parse(path)
    service_sheet = book['Service References'] 
    if service_sheet
    service_sheet[3..-1].each { |row|
        if row and row.cells[1] and row.cells[2]
            ws_count = row.cells[1].value
            service_name = row.cells[2].value     
            pathindex= findPathIndex(service_sheet,"OSB Resource Path")
            service_path = row.cells[pathindex].value
            service_operation = row.cells[3].value
            if ws_count and !ws_count.start_with? 'Note:' and service_name and service_path
                new_sheet.insert_cell(index, 0, composite_name) 
                new_sheet.insert_cell(index, 1, operation_name) 
                new_sheet.insert_cell(index, 2, ws_count) 
                new_sheet.insert_cell(index, 3, service_name) 
                 new_sheet.insert_cell(index, 4, service_operation) 
                new_sheet.insert_cell(index, 5, service_path)
                index +=1
            end
        end
    
}
	
end
end
workbook.write(result_excel_file_name)