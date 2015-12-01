namespace :archive do

  desc 'esa.io のエクスポートをインポートする'
  task :import_esa_io => :environment do
    archive_root = Rails.root.join('esa_archives', 'articles')
    user_esa = User.find(1)
    Dir.glob(archive_root + "**/*.md") do |filename|
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
      article.title = metas['category'] + '/' + metas['title'][1..(-2)]
      article.text = text
      article.created_at = metas['created_at']
      article.updated_at = metas['updated_at']
      article.tag_list << header['tags'].split(',')
      article.save
    end
  end
end
