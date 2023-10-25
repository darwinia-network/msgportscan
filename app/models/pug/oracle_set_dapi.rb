class Pug::OracleSetDapi < ApplicationRecord
  belongs_to :pug_evm_log, class_name: 'Pug::EvmLog'
  alias evm_log pug_evm_log

end
