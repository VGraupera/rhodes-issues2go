module ApplicationHelper
  def strip_braces(str=nil)
    str ? str.gsub(/\{/,"").gsub(/\}/,"") : nil
  end
  
  def strike_if(str, condition=true)
    condition ? "<s>#{str}</s>" : str
  end
  
  def resolved?(ticket)
    ticket.state == "resolved"
  end
  
  def display_blanks(value)
    if blank?(value)
      "---"
    else
      value
    end
  end
  
  def blank?(value)
    value.nil? || value == "" || value.length==0
  end
  
  def time_stamp(time)
    Time.parse(time).strftime("%B %d, %Y @ %I:%M%p") 
  end
  
  def ticket_details(ticket, project)
    %Q(<div>#{strike_if("<span class=\"name\">\"#{ticket.title}\"</span>", resolved?(ticket))}</div>
		<span class="ticket_meta">#{strike_if("##{display_blanks(ticket.number)}", resolved?(ticket))} / #{project.name} / <span class="#{display_blanks(ticket.state)}"> #{ticket.state}</span></span>)
  end
end