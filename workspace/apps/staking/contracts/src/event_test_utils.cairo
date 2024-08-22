use starknet::{ContractAddress};
use contracts::staking::interface;
use contracts::staking::Events as StakingEvents;
use contracts::pooling::Events as PoolEvents;
use snforge_std::cheatcodes::events::{Event, Events, EventSpy, EventSpyTrait, is_emitted};

pub fn assert_number_of_events(actual: u32, expected: u32, message: ByteArray) {
    assert_eq!(
        actual, expected, "{actual} events were emitted instead of {expected}. Context: {message}"
    );
}

pub fn panic_with_event_details(expected_emitted_by: @ContractAddress, details: ByteArray) {
    let start = format!("Could not match expected event from address {:?}", *expected_emitted_by);
    panic!("{}: {}", start, details);
}

pub fn assert_staker_exit_intent_event(
    spied_event: @(ContractAddress, Event),
    staker_address: ContractAddress,
    exit_timestamp: u64,
    amount: u128
) {
    let expected_event = @contracts::staking::Staking::Event::StakerExitIntent(
        StakingEvents::StakerExitIntent { staker_address, exit_timestamp, amount }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "StakerExitIntent{{staker_address: {:?}, exit_timestamp: {}, amount: {}}}",
            staker_address,
            exit_timestamp,
            amount
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn assert_stake_balance_change_event(
    spied_event: @(ContractAddress, Event),
    staker_address: ContractAddress,
    old_self_stake: u128,
    old_delegated_stake: u128,
    new_self_stake: u128,
    new_delegated_stake: u128
) {
    let expected_event = @contracts::staking::Staking::Event::StakeBalanceChange(
        StakingEvents::StakeBalanceChange {
            staker_address, old_self_stake, old_delegated_stake, new_self_stake, new_delegated_stake
        }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "StakingEvents::StakeBalanceChange{{staker_address: {:?}, old_self_stake: {}, 
                old_delegated_stake: {}, new_self_stake: {}, new_delegated_stake: {}}}",
            staker_address,
            old_self_stake,
            old_delegated_stake,
            new_self_stake,
            new_delegated_stake
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn assert_pool_member_exit_intent_event(
    spied_event: @(ContractAddress, Event),
    pool_member: ContractAddress,
    exit_timestamp: u64,
    amount: u128,
) {
    let expected_event = @contracts::pooling::Pooling::Event::PoolMemberExitIntent(
        PoolEvents::PoolMemberExitIntent { pool_member, exit_timestamp, amount }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "PoolMemberExitIntent{{pool_member: {:?}, exit_timestamp: {}, amount: {}}}",
            pool_member,
            exit_timestamp,
            amount
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn assert_delegation_balance_change_event(
    mut spied_event: @(ContractAddress, Event),
    pool_member: ContractAddress,
    old_delegated_stake: u128,
    new_delegated_stake: u128,
) {
    let expected_event = @contracts::pooling::Pooling::Event::DelegationBalanceChange(
        PoolEvents::DelegationBalanceChange {
            pool_member, old_delegated_stake, new_delegated_stake
        }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "PoolEvents::DelegationBalanceChange{{pool_member: {:?}, old_delegated_stake: {}, new_delegated_stake: {}}}",
            pool_member,
            old_delegated_stake,
            new_delegated_stake
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn assert_staker_reward_address_change_event(
    spied_event: @(ContractAddress, Event),
    staker_address: ContractAddress,
    new_address: ContractAddress,
    old_address: ContractAddress,
) {
    let expected_event = @contracts::staking::Staking::Event::StakerRewardAddressChanged(
        StakingEvents::StakerRewardAddressChanged { staker_address, new_address, old_address }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "StakerRewardAddressChanged{{staker_address: {:?}, new_address: {:?}, old_address: {:?}}}",
            staker_address,
            new_address,
            old_address
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn assert_global_index_updated_event(
    spied_event: @(ContractAddress, Event),
    old_index: u64,
    new_index: u64,
    last_index_update_timestamp: u64,
    current_index_update_timestamp: u64,
) {
    let expected_event = @contracts::staking::Staking::Event::GlobalIndexUpdated(
        StakingEvents::GlobalIndexUpdated {
            old_index, new_index, last_index_update_timestamp, current_index_update_timestamp
        }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "GlobalIndexUpdated{{old_index: {}, new_index: {}, last_index_update_timestamp: {}, current_index_update_timestamp: {}}}",
            old_index,
            new_index,
            last_index_update_timestamp,
            current_index_update_timestamp
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn assert_new_delegation_pool_event(
    mut spied_event: @(ContractAddress, Event),
    staker_address: ContractAddress,
    pool_contract: ContractAddress,
    commission: u16
) {
    let expected_event = @contracts::staking::Staking::Event::NewDelegationPool(
        StakingEvents::NewDelegationPool { staker_address, pool_contract, commission }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "StakingEvents::NewDelegationPool{{staker_address: {:?}, pool_contract: {:?}, commission: {}}}",
            staker_address,
            pool_contract,
            commission
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn assert_pool_member_reward_address_change_event(
    spied_event: @(ContractAddress, Event),
    pool_member: ContractAddress,
    new_address: ContractAddress,
    old_address: ContractAddress,
) {
    let expected_event = @contracts::pooling::Pooling::Event::PoolMemberRewardAddressChanged(
        PoolEvents::PoolMemberRewardAddressChanged { pool_member, new_address, old_address }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "PoolMemberRewardAddressChanged{{pool_member: {:?}, new_address: {:?}, old_address: {:?}}}",
            pool_member,
            new_address,
            old_address
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn assert_change_operational_address_event(
    spied_event: @(ContractAddress, Event),
    staker_address: ContractAddress,
    new_address: ContractAddress,
    old_address: ContractAddress,
) {
    let expected_event = @contracts::staking::Staking::Event::OperationalAddressChanged(
        StakingEvents::OperationalAddressChanged { staker_address, new_address, old_address }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "OperationalAddressChanged{{staker_address: {:?}, new_address: {:?}, old_address: {:?}}}",
            staker_address,
            new_address,
            old_address
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub(crate) fn assert_final_index_set_event(
    spied_event: @(ContractAddress, Event), staker_address: ContractAddress, final_staker_index: u64
) {
    let expected_event = @contracts::pooling::Pooling::Event::FinalIndexSet(
        PoolEvents::FinalIndexSet { staker_address, final_staker_index }
    );
    let (expected_emitted_by, raw_event) = spied_event;
    let wrapped_spied_event = Events { events: array![(*expected_emitted_by, raw_event.clone())] };
    let emitted = is_emitted(self: @wrapped_spied_event, :expected_emitted_by, :expected_event);
    if !emitted {
        let details = format!(
            "FinalIndexSet{{staker_address: {:?}, final_staker_index: {}}}",
            staker_address,
            final_staker_index
        );
        panic_with_event_details(:expected_emitted_by, :details);
    }
}

pub fn debug_dump_spied_events(ref spy: EventSpy) {
    let mut serialized = array![];
    Serde::<
        Array<(starknet::ContractAddress, snforge_std::Event)>
    >::serialize(@(spy.get_events().events), ref serialized);
    println!("{:?}", serialized);
    println!("[#events, (emitterAddress, #keys, keys..., #values, values...)...]");
}
