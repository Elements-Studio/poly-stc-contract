address 0x2d81a0427d64ff61b11ede9085efa5ad {

module CrossChainScript {

    use 0x1::STC;

    use 0x2d81a0427d64ff61b11ede9085efa5ad::CrossChainGlobal;
    use 0x2d81a0427d64ff61b11ede9085efa5ad::CrossChainData;
    use 0x2d81a0427d64ff61b11ede9085efa5ad::CrossChainManager;
    use 0x2d81a0427d64ff61b11ede9085efa5ad::CrossChainRouter;
    use 0x2d81a0427d64ff61b11ede9085efa5ad::LockProxy;
    use 0x2d81a0427d64ff61b11ede9085efa5ad::XETH;
    use 0x2d81a0427d64ff61b11ede9085efa5ad::XUSDT;

    const CHAINID_STARCOIN: u64 = 218;
    const CHAINID_ETHEREUM: u64 = 2;

    /// Initialize genesis from contract owner
    public(script) fun init_genesis(signer: signer,
                                    current_chain_id: u64,
                                    raw_header: vector<u8>,
                                    pub_key_list: vector<u8>) {
        init_genesis_with_chain_id(
            &signer,
            &raw_header,
            &pub_key_list,
            current_chain_id,
            CHAINID_STARCOIN,
            CHAINID_ETHEREUM);

        // Bind default proxy hash and asset hash to self chain
        LockProxy::bind_proxy_hash<CrossChainGlobal::STARCOIN_CHAIN>(
            &signer, CHAINID_STARCOIN, &b"0x2d81a0427d64ff61b11ede9085efa5ad::CrossChainScript");
        LockProxy::bind_asset_hash<STC::STC, CrossChainGlobal::STARCOIN_CHAIN>(
            &signer, CHAINID_STARCOIN, &b"0x00000000000000000000000000000001::STC::STC");
        LockProxy::bind_asset_hash<XETH::XETH, CrossChainGlobal::STARCOIN_CHAIN>(
            &signer, CHAINID_STARCOIN, &b"0x2d81a0427d64ff61b11ede9085efa5ad::XETH::XETH");
        LockProxy::bind_asset_hash<XUSDT::XUSDT, CrossChainGlobal::STARCOIN_CHAIN>(
            &signer, CHAINID_STARCOIN, &b"0x2d81a0427d64ff61b11ede9085efa5ad::XUSDT::XUSDT");
    }

    public fun init_genesis_with_chain_id(signer: &signer,
                                          raw_header: &vector<u8>,
                                          pub_key_list: &vector<u8>,
                                          current_chain_id: u64,
                                          stc_chain_id: u64,
                                          eth_chain_id: u64) {
        // Init CCD
        CrossChainData::init_genesis(signer);

        // Init CCM
        CrossChainManager::init_genesis_block(signer, current_chain_id, raw_header, pub_key_list);

        // Init asset proxy asset
        LockProxy::init_event(signer);

        // Initialize default chain id
        CrossChainGlobal::set_chain_id<CrossChainGlobal::STARCOIN_CHAIN>(signer, stc_chain_id);
        CrossChainGlobal::set_chain_id<CrossChainGlobal::ETHEREUM_CHAIN>(signer, eth_chain_id);
    }


    // Lock operation from user call
    public(script) fun lock(signer: signer,
                            from_asset_hash: vector<u8>,
                            to_chain_id: u64,
                            to_address: vector<u8>,
                            amount: u128) {
        CrossChainRouter::lock(&signer, &from_asset_hash, to_chain_id, &to_address, amount);
    }

    /// Check book keeper information
    public(script) fun change_book_keeper(signer: signer,
                                          raw_header: vector<u8>,
                                          pub_key_list: vector<u8>,
                                          sig_list: vector<u8>) {
        CrossChainManager::change_book_keeper(&signer, &raw_header, &pub_key_list, &sig_list);
    }

    /// Verify header and execute transaction
    public(script) fun verify_header_and_execute_tx(proof: vector<u8>,
                                                    raw_header: vector<u8>,
                                                    header_proof: vector<u8>,
                                                    cur_raw_header: vector<u8>,
                                                    header_sig: vector<u8>,
                                                    merkle_proof_root: vector<u8>,
                                                    merkle_proof_leaf: vector<u8>,
                                                    merkle_proof_siblings: vector<u8>) {
        CrossChainRouter::verify_header_and_execute_tx(
            &proof,
            &raw_header,
            &header_proof,
            &cur_raw_header,
            &header_sig,
            &merkle_proof_root,
            &merkle_proof_leaf,
            &merkle_proof_siblings);
    }

    /// Get Current Epoch Start Height of Poly chain block
    public fun get_cur_epoch_start_height(): u64 {
        CrossChainData::get_cur_epoch_start_height()
    }

    /// Get Consensus book Keepers Public Key Bytes
    public fun get_cur_epoch_con_pubkey_bytes(): vector<u8> {
        CrossChainData::get_cur_epoch_con_pubkey_bytes()
    }

    public(script) fun bind_proxy_hash(signer: signer, chain_id: u64, target_proxy_hash: vector<u8>) {
        CrossChainRouter::bind_proxy_hash(&signer, chain_id, &target_proxy_hash);
    }

    public(script) fun bind_asset_hash(signer: signer, from_asset_hash: vector<u8>, chain_id: u64, to_asset_hash: vector<u8>) {
        CrossChainRouter::bind_asset_hash(&signer, &from_asset_hash, chain_id, &to_asset_hash);
    }
}
}