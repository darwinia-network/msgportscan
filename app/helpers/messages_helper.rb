module MessagesHelper
  def status_style(status)
    if status == 'accepted'
      'inline-block whitespace-nowrap rounded-full bg-primary-100 px-[0.65em] pb-[0.25em] pt-[0.35em] text-center align-baseline text-[0.75em] font-bold leading-none text-primary-700'
    elsif status == 'root_ready'
      'inline-block whitespace-nowrap rounded-full bg-secondary-100 px-[0.65em] pb-[0.25em] pt-[0.35em] text-center align-baseline text-[0.75em] font-bold leading-none text-secondary-800'
    elsif status == 'dispatch_failed'
      'inline-block whitespace-nowrap rounded-full bg-danger-100 px-[0.65em] pb-[0.25em] pt-[0.35em] text-center align-baseline text-[0.75em] font-bold leading-none text-danger-700'
    elsif status == 'dispatch_success'
      'inline-block whitespace-nowrap rounded-full bg-success-100 px-[0.65em] pb-[0.25em] pt-[0.35em] text-center align-baseline text-[0.75em] font-bold leading-none text-success-700'
    elsif status == 'cleared'
      'inline-block whitespace-nowrap rounded-full bg-neutral-50 px-[0.65em] pb-[0.25em] pt-[0.35em] text-center align-baseline text-[0.75em] font-bold leading-none text-neutral-600'
    end
  end

  def time_consumption(message)
    return unless message.status == 'dispatch_success' || message.status == 'dispatch_failed'

    # to human readable
    distance_of_time_in_words(
      Time.at(message.block_timestamp),
      Time.at(message.dispatch_block_timestamp)
    )
  end
end
