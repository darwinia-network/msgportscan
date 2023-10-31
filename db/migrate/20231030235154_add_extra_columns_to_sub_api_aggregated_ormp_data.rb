class AddExtraColumnsToSubApiAggregatedOrmpData < ActiveRecord::Migration[7.1]
  def up
    %i[
      pug_ormp_app_config_updateds
      pug_ormp_clear_failed_messages
      pug_ormp_message_accepteds
      pug_ormp_message_dispatcheds
      pug_ormp_retry_failed_messages
      pug_ormp_set_default_configs
      pug_relayer_assigneds
      pug_relayer_set_approveds
      pug_relayer_set_dst_configs
      pug_relayer_set_dst_prices
      pug_oracle_assigneds
      pug_oracle_set_approveds
      pug_oracle_set_dapis
      pug_oracle_set_fees
      pug_sub_api_add_beacons
      pug_sub_api_aggregated_ormp_data
      pug_sub_api_airnode_rrp_completeds
      pug_sub_api_airnode_rrp_requesteds
      pug_sub_api_ownership_transfer_starteds
      pug_sub_api_ownership_transferreds
      pug_sub_api_remove_beacons
      pug_sub_api_sub_api_feed_updateds
    ].each do |table|
      add_column table, :block_number, :integer
      add_column table, :timestamp, :datetime
    end
  end

  def down
    %i[
      pug_ormp_app_config_updateds
      pug_ormp_clear_failed_messages
      pug_ormp_message_accepteds
      pug_ormp_message_dispatcheds
      pug_ormp_retry_failed_messages
      pug_ormp_set_default_configs
      pug_relayer_assigneds
      pug_relayer_set_approveds
      pug_relayer_set_dst_configs
      pug_relayer_set_dst_prices
      pug_oracle_assigneds
      pug_oracle_set_approveds
      pug_oracle_set_dapis
      pug_oracle_set_fees
      pug_sub_api_add_beacons
      pug_sub_api_aggregated_ormp_data
      pug_sub_api_airnode_rrp_completeds
      pug_sub_api_airnode_rrp_requesteds
      pug_sub_api_ownership_transfer_starteds
      pug_sub_api_ownership_transferreds
      pug_sub_api_remove_beacons
      pug_sub_api_sub_api_feed_updateds
    ].each do |table|
      remove_column table, :block_number, :integer
      remove_column table, :timestamp, :datetime
    end
  end
end
