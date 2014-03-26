atom_feed do |feed|
  feed.title "Foster Parents"
  feed.updated @latest_parent.try(:updated_at)

  FosterParent.all.each do |parent|
    puts parent.name
    feed.entry(parent) do |entry|
      entry.title "New foster parent #{parent.name}"
      entry.summary type: 'xhtml' do |xhtml|
        xhtml.p "Parent name: #{parent.name}"
        xhtml.p "Parent address: #{parent.address}"
        xhtml.p "Pet name: #{(Pet.find parent.pet_id).name}"
      end
      entry.author do |author|
        author.name parent.name
        author.email parent.email
      end
    end
  end
end

