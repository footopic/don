namespace :archive do

  desc 'esa.io のエクスポートをインポートする'
  task :import_esa_io => :environment do
    archive_root = Rails.root.join('import', 'articles')
    user_esa = User.find_or_create_by!(uid: 0, provider: 'esa', screen_name: 'esa', name: 'esa.io')
    user_esa.save_icon(File.open(Rails.root.join('import', 'images', 'esa_icon.png')))
    dirs = Dir.glob(archive_root + '**/*.md')
    dirs.each do |filename|
      # cout
      puts filename
      f = File.read(filename, :encoding => Encoding::UTF_8)
      header, text = f.split('---').drop(1).map &:strip
      metas = Hash[*(header.split("\n").map do |s|
        a, b = s.split(': ')
        b = '' if !b
        [a, b]
      end.flatten)]
      if metas['published'] == 'false'
        next
      end
      article = user_esa.articles.build
      article.title = metas['title'][1..(-2)]
      article.text = text
      article.created_at = metas['created_at']
      article.updated_at = metas['updated_at']
      article.tag_list << metas['tags'].split(',')
      categories = metas['category'].split('/')
      article.tag_list << categories[0]
      article.save
    end
    puts "successfly #{dirs.length} archives imported"
  end

  desc 'esa user 作成'
  task :create_esa_user => :environment do
    user_esa = User.find_or_create_by!(uid: 0, provider: 'esa', screen_name: 'esa', name: 'esa.io')
    user_esa.save_icon(File.open(Rails.root.join('import', 'images', 'esa_icon.png')))
  end
end