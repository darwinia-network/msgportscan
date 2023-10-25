# == Schema Information
#
# Table name: pug_ormp_message_accepteds
#
#  id                      :bigint           not null, primary key
#  pug_evm_log_id          :bigint           not null
#  pug_evm_contract_id     :bigint           not null
#  pug_network_id          :bigint           not null
#  e_msg_hash              :string
#  e_root                  :string
#  e_message_channel       :string
#  e_message_index         :decimal(78, )
#  e_message_from_chain_id :decimal(78, )
#  e_message_from          :string
#  e_message_to_chain_id   :decimal(78, )
#  e_message_to            :string
#  e_message_encoded       :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Pug::OrmpMessageAccepted < ApplicationRecord
  belongs_to :pug_evm_log, class_name: 'Pug::EvmLog'
  alias evm_log pug_evm_log
  belongs_to :pug_evm_contract, class_name: 'Pug::EvmContract'
  alias evm_contract pug_evm_contract
  belongs_to :pug_network, class_name: 'Pug::Network'
  alias network pug_network
end
