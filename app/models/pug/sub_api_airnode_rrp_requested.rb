# == Schema Information
#
# Table name: pug_sub_api_airnode_rrp_requesteds
#
#  id                  :bigint           not null, primary key
#  pug_evm_log_id      :bigint           not null
#  pug_evm_contract_id :bigint           not null
#  pug_network_id      :bigint           not null
#  e_beacon_id         :string
#  e_request_id        :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Pug::SubApiAirnodeRrpRequested < ApplicationRecord
  belongs_to :pug_evm_log, class_name: 'Pug::EvmLog'
  alias evm_log pug_evm_log
  belongs_to :pug_evm_contract, class_name: 'Pug::EvmContract'
  alias evm_contract pug_evm_contract
  belongs_to :pug_network, class_name: 'Pug::Network'
  alias network pug_network
end
