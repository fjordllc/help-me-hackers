atom_feed(
  :language => 'ja-JP',
  'xmlns:app' => 'http://www.w3.org/2007/app',
  'xmlns:openSearch' => 'http://a9.com/-/spec/opensearch/1.1/'
) do |feed|
  feed.title("未解決 | #{t('application.title')}")
  feed.updated(@tasks.first.updated_at)
  @tasks.each do |task|
    feed.entry(task) do |entry|
      entry.title(task.title)
      entry.content(markdown(task.description), :type => "html")
      entry.author do |a|
        a.name("@#{task.user.login}")
      end
    end
  end
end
