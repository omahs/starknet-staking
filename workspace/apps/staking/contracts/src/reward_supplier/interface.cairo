use starknet::{ContractAddress, EthAddress};
use contracts::types::Amount;
use contracts_commons::types::time::TimeStamp;

#[starknet::interface]
pub trait IRewardSupplier<TContractState> {
    // Calculates the rewards since the last_timestamp, and return the index diff.
    fn calculate_staking_rewards(ref self: TContractState) -> u128;
    // Transfers rewards to the staking contract.
    fn claim_rewards(ref self: TContractState, amount: Amount);
    fn on_receive(
        ref self: TContractState,
        l2_token: ContractAddress,
        amount: u256,
        depositor: EthAddress,
        message: Span<felt252>
    );
    fn contract_parameters(self: @TContractState) -> RewardSupplierInfo;
}

#[derive(Debug, Copy, Drop, Serde, PartialEq)]
pub struct RewardSupplierInfo {
    pub last_timestamp: TimeStamp,
    pub unclaimed_rewards: Amount,
    pub l1_pending_requested_amount: Amount,
}

pub mod Events {
    use contracts::types::Amount;
    use contracts_commons::types::time::TimeStamp;

    #[derive(Drop, starknet::Event)]
    pub struct MintRequest {
        pub total_amount: Amount,
        pub num_msgs: u128,
    }

    #[derive(Drop, starknet::Event)]
    pub struct CalculatedRewards {
        pub last_timestamp: TimeStamp,
        pub new_timestamp: TimeStamp,
        pub rewards_calculated: Amount,
    }
}
