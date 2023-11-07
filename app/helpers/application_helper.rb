module ApplicationHelper
  def short(hex)
    "#{hex[0..5]}..#{hex[-4..]}"
  end

  def md_short(hex)
    "#{hex[0..6]}..#{hex[-5..]}"
  end

  def address_link(network, address)
    contract = Pug::EvmContract.find_by(address:)
    display = address + (contract.nil? ? '' : "(#{contract.name})")
    url = File.join(network.explorer, 'address', address)
    %(<a href="#{url}" class="underline">#{display}</a>).html_safe
  end

  def address_link_short(network, address)
    contract = Pug::EvmContract.find_by(address:)
    display = contract&.name || short(address)
    url = File.join(network.explorer, 'address', address)
    %(<a href="#{url}" class="underline">#{display}</a>).html_safe
  end

  def transaction_link(network, tx_hash)
    url = File.join(network.explorer, 'tx', tx_hash)
    %(<a href="#{url}" class="underline">#{tx_hash}</a>).html_safe
  end

  def block_link(network, block_number)
    url = File.join(network.explorer, 'block', block_number.to_s)
    %(<a href="#{url}" class="underline">#{block_number}</a>).html_safe
  end

  def from_link(message)
    network = message.from_network

    contract = Pug::EvmContract.find_by(address: message.from)
    if contract
      transaction = Pug::EvmTransaction.find_by(transaction_hash: message.transaction_hash)
      enduser_address = transaction.from
      ea_url = File.join(network.explorer, 'address', enduser_address)
      ua_url = File.join(network.explorer, 'address', message.from)
      %(
        <a href="#{ea_url}" class="underline text-xs">#{enduser_address}</a></br>
        └╴<a href="#{ua_url}" class="underline">#{"#{message.from}(#{contract.name})"}</a>
      ).html_safe
    else
      display = message.from
      url = File.join(network.explorer, 'address', message.from)
      %(<a href="#{url}" class="underline">#{display}</a>).html_safe
    end
  end

  def to_link(message)
    network = message.to_network

    contract = Pug::EvmContract.find_by(address: message.to)
    if contract && contract.name.end_with?('Line')

      # https://github.com/darwinia-network/darwinia-msgport/blob/6f751cf02f2ea0fbb2de401cd3cf07cca68e1b49/src/lines/ORMPLine.sol#L64
      # recv(address,address,bytes)
      # 0x394d1bca
      #   0000000000000000000000009f33a4809aa708d7a399fedba514e0a0d15efa85 <- `source EA` address
      #   000000000000000000000000422df988fda9c7bac5750ee9ea6a46d7a024e99e <- `target EA` address
      #   0000000000000000000000000000000000000000000000000000000000000060
      #   0000000000000000000000000000000000000000000000000000000000000064
      #   d8e6817200000000000000000000000000000000000000000000000000000000 <- the message sent to `target EA`
      #   0000002000000000000000000000000000000000000000000000000000000000
      #   0000000212340000000000000000000000000000000000000000000000000000
      #   0000000000000000000000000000000000000000000000000000000000000000
      #   0e3bede4f813af49d539dba8bf19f49386acd6670a5ffea93814d7a5ce5291c2
      #   000000000000000000000000000000000000000000000000000000000000002c
      #   001ddfd752a071964fe15c2386ec1811963d00c2

      # target_ua -> target_ea
      target_ua = message.to
      target_ea = '0x' + message.encoded[98..137]
      ua_url = File.join(network.explorer, 'address', target_ua)
      ea_url = File.join(network.explorer, 'address', target_ea)
      %(
        <a href="#{ua_url}" class="underline">#{target_ua}(#{contract.name})</a></br>
        └╴<a href="#{ea_url}" class="underline text-xs">#{target_ea}</a>
      ).html_safe
    else
      display = message.to
      url = File.join(network.explorer, 'address', message.to)
      %(<a href="#{url}" class="underline">#{display}</a>).html_safe
    end
  end
end
