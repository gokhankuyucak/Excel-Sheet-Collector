# A Ruby script that lists the pipeline proxy, xquery files which have version 1.0
service_files =  Dir.glob('**/*.{proxy,pipeline,xqy}')

def check_pxpipeline(content,file)  
        contentiswrong = content.match(/:snippetVersion>1.0</)
        if contentiswrong
            puts file
        end
end
def check_xquery(content,file)  
        contentiswrong = content.match(/xquery version "1.0";/)
        if contentiswrong
            puts file
        end
end
    
service_files.each do |file|
        content = File.read(file)
        file_ext = File.extname(file)
        if (['.proxy','.pipeline']).include?(file_ext)
            check_pxpipeline(content,file)
        else
            check_xquery(content,file)
        end
end