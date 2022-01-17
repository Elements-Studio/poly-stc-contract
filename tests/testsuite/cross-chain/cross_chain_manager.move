//! account: alice, 0x18351d311d32201149a4df2a9fc2db8a, 10000000000 0x1::STC::STC
//! account: bob, 0x49156896A605F092ba1862C50a9036c9, 10000000000 0x1::STC::STC


//! new-transaction
//! sender: alice
address alice = {{alice}};
module alice::CrossChainType {

    struct XETH has copy, drop, store {}

    struct XBTC has copy, drop, store {}

    struct Ethereum has key, store {}

    struct Bitcoin has key, store {}

    struct Starcoin has key, store {}

}


//! new-transaction
//! sender: alice
address alice = {{alice}};
script {
    use 0x1::STC;
    use 0x18351d311d32201149a4df2a9fc2db8a::CrossChainScript;
    use 0x18351d311d32201149a4df2a9fc2db8a::CrossChainGlobal;
    use 0x18351d311d32201149a4df2a9fc2db8a::LockProxy;

    const CHAINID_STARCOIN: u64 = 8;
    const CHAINID_ETHEREUM: u64 = 1;

    fun test_genesis_init(signer: signer) {
        let raw_header = x"000000009b9156170000000000000000000000000000000000000000000000000000000000000000000000006de0a8f7ee3fb67d8e04ac9547f3615e59adc6e0a2309c90080a272dc1fa1fd90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8365b000000001dac2b7c00000000fd1a057b226c6561646572223a343239343936373239352c227672665f76616c7565223a22484a675171706769355248566745716354626e6443456c384d516837446172364e4e646f6f79553051666f67555634764d50675851524171384d6f38373853426a2b38577262676c2b36714d7258686b667a72375751343d222c227672665f70726f6f66223a22785864422b5451454c4c6a59734965305378596474572f442f39542f746e5854624e436667354e62364650596370382f55706a524c572f536a5558643552576b75646632646f4c5267727052474b76305566385a69413d3d222c226c6173745f636f6e6669675f626c6f636b5f6e756d223a343239343936373239352c226e65775f636861696e5f636f6e666967223a7b2276657273696f6e223a312c2276696577223a312c226e223a372c2263223a322c22626c6f636b5f6d73675f64656c6179223a31303030303030303030302c22686173685f6d73675f64656c6179223a31303030303030303030302c22706565725f68616e647368616b655f74696d656f7574223a31303030303030303030302c227065657273223a5b7b22696e646578223a312c226964223a2231323035303238313732393138353430623262353132656165313837326132613265336132386439383963363064393564616238383239616461376437646437303664363538227d2c7b22696e646578223a322c226964223a2231323035303338623861663632313065636664636263616232323535326566386438636634316336663836663963663961623533643836353734316366646238333366303662227d2c7b22696e646578223a332c226964223a2231323035303234383261636236353634623139623930363533663665396338303632393265386161383366373865376139333832613234613665666534316330633036663339227d2c7b22696e646578223a342c226964223a2231323035303236373939333061343261616633633639373938636138613366313265313334633031393430353831386437383364313137343865303339646538353135393838227d2c7b22696e646578223a352c226964223a2231323035303234363864643138393965643264316363326238323938383261313635613065636236613734356166306337326562323938326436366234333131623465663733227d2c7b22696e646578223a362c226964223a2231323035303265623162616162363032633538393932383235363163646161613761616262636464306363666362633365373937393361633234616366393037373866333561227d2c7b22696e646578223a372c226964223a2231323035303331653037373966356335636362323631323335326665346132303066393964336537373538653730626135336636303763353966663232613330663637386666227d5d2c22706f735f7461626c65223a5b362c342c332c352c362c312c322c352c342c372c342c322c332c332c372c362c352c342c362c352c312c342c332c312c322c352c322c322c362c312c342c352c342c372c322c332c342c312c352c372c342c312c322c322c352c362c342c342c322c372c332c362c362c352c312c372c332c312c362c312c332c332c322c342c342c312c352c362c352c312c322c362c372c352c362c332c342c372c372c332c322c372c312c352c362c352c322c332c362c322c362c312c372c372c372c312c372c342c332c332c332c322c312c372c355d2c226d61785f626c6f636b5f6368616e67655f76696577223a36303030307d7d9fe171f3fe643eb1c188400b828ba184816fc9ac0000";
        let pub_key_list = x"1205041e0779f5c5ccb2612352fe4a200f99d3e7758e70ba53f607c59ff22a30f678ff757519efff911efc7ed326890a2752b9456cc0054f9b63215f1d616e574d6197120504468dd1899ed2d1cc2b829882a165a0ecb6a745af0c72eb2982d66b4311b4ef73cff28a6492b076445337d8037c6c7be4d3ec9c4dbe8d7dc65d458181de7b5250120504482acb6564b19b90653f6e9c806292e8aa83f78e7a9382a24a6efe41c0c06f39ef0a95ee60ad9213eb0be343b703dd32b12db32f098350cf3f4fc3bad6db23ce120504679930a42aaf3c69798ca8a3f12e134c019405818d783d11748e039de8515988754f348293c65055f0f1a9a5e895e4e7269739e243a661fff801941352c387121205048172918540b2b512eae1872a2a2e3a28d989c60d95dab8829ada7d7dd706d658df044eb93bbe698eff62156fc14d6d07b7aebfbc1a98ec4180b4346e67cc3fb01205048b8af6210ecfdcbcab22552ef8d8cf41c6f86f9cf9ab53d865741cfdb833f06b72fcc7e7d8b9e738b565edf42d8769fd161178432eadb2e446dd0a8785ba088f120504eb1baab602c5899282561cdaaa7aabbcdd0ccfcbc3e79793ac24acf90778f35a059fca7f73aeb60666178db8f704b58452b7a0b86219402c0770fcb52ac9828c";

        CrossChainScript::inner_init_genesis(
            &signer,
            &raw_header,
            &pub_key_list);

        CrossChainGlobal::set_chain_id<CrossChainGlobal::STARCOIN_CHAIN>(&signer, CHAINID_STARCOIN);
        CrossChainGlobal::set_chain_id<CrossChainGlobal::ETHEREUM_CHAIN>(&signer, CHAINID_ETHEREUM);

        CrossChainGlobal::set_asset_hash<STC::STC>(&signer, &x"0000000000000000000000000000000000000000");

        LockProxy::bind_proxy_hash<CrossChainGlobal::STARCOIN_CHAIN>(
            &signer, CHAINID_STARCOIN, &x"f71b55ef55cedc91fd007f7a9ba386ec978f3aa8");
        LockProxy::bind_asset_hash<STC::STC, CrossChainGlobal::STARCOIN_CHAIN>(
            &signer, CHAINID_STARCOIN, &x"0000000000000000000000000000000000000000");


        assert(CrossChainGlobal::asset_hash_match<STC::STC>(&x"0000000000000000000000000000000000000000"), 10001);
        assert(CrossChainGlobal::chain_id_match<CrossChainGlobal::STARCOIN_CHAIN>(CHAINID_STARCOIN), 10002);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: alice
address alice = {{alice}};
script {
    use 0x1::Vector;

    use 0x18351d311d32201149a4df2a9fc2db8a::CrossChainScript;

    /// Excep failed for repeate initialize errors
    fun test_repeate_call_genesis_init(signer: signer) {
        CrossChainScript::inner_init_genesis(&signer, &Vector::empty<u8>(), &Vector::empty<u8>());
    }
}
// check: "Keep(ABORTED { code: 25857"

//! new-transaction
//! sender: alice
address alice = {{alice}};
script {
    use 0x18351d311d32201149a4df2a9fc2db8a::CrossChainManager;

    fun test_change_book_keeper(signer: signer) {
        let raw_header = x"000000009b91561700000000f48a4057bef268cc3fdb034e69dc2e942907e08ac4a420d1b196b8c28ebf5bf2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002a8be0a1605a63a31704aec4eb4f1023f1ecc2934bd86f119ab77526f9477af9a57e1a5f508e0000410782720ab189fffd84057b226c6561646572223a332c227672665f76616c7565223a22424f4f336f58796b32524970655651593338547133714a423832737a4a68366e4f6f724a55702f4a4d582b474c707a347a497347394c4a6c34784a6f34657448674f56357169364d484b6674714f69724f755a495a69593d222c227672665f70726f6f66223a22635953525746506f69394748414247526255646836612b35506f4f317776354a557a53417457786845637071757430536a595873344c7453353574534a74334174493059616d4c67524a797a524f68564756626d34673d3d222c226c6173745f636f6e6669675f626c6f636b5f6e756d223a33363433322c226e65775f636861696e5f636f6e666967223a7b2276657273696f6e223a312c2276696577223a342c226e223a382c2263223a322c22626c6f636b5f6d73675f64656c6179223a31303030303030303030302c22686173685f6d73675f64656c6179223a31303030303030303030302c22706565725f68616e647368616b655f74696d656f7574223a31303030303030303030302c227065657273223a5b7b22696e646578223a312c226964223a2231323035303238313732393138353430623262353132656165313837326132613265336132386439383963363064393564616238383239616461376437646437303664363538227d2c7b22696e646578223a342c226964223a2231323035303236373939333061343261616633633639373938636138613366313265313334633031393430353831386437383364313137343865303339646538353135393838227d2c7b22696e646578223a332c226964223a2231323035303234383261636236353634623139623930363533663665396338303632393265386161383366373865376139333832613234613665666534316330633036663339227d2c7b22696e646578223a352c226964223a2231323035303234363864643138393965643264316363326238323938383261313635613065636236613734356166306337326562323938326436366234333131623465663733227d2c7b22696e646578223a382c226964223a2231323035303339333432313434356239343231626434636339306437626338386339333031353538303437613736623230633539653763353131656537643232393938326231227d2c7b22696e646578223a322c226964223a2231323035303338623861663632313065636664636263616232323535326566386438636634316336663836663963663961623533643836353734316366646238333366303662227d2c7b22696e646578223a372c226964223a2231323035303331653037373966356335636362323631323335326665346132303066393964336537373538653730626135336636303763353966663232613330663637386666227d2c7b22696e646578223a362c226964223a2231323035303265623162616162363032633538393932383235363163646161613761616262636464306363666362633365373937393361633234616366393037373866333561227d5d2c22706f735f7461626c65223a5b322c382c352c352c382c372c312c342c352c362c352c342c372c372c332c332c342c362c312c322c342c382c352c342c372c342c362c362c322c322c312c312c382c382c362c362c362c372c382c372c342c382c352c312c332c332c382c352c332c362c332c362c372c352c362c322c332c312c322c362c352c322c312c342c322c312c382c342c382c332c382c372c372c352c312c372c342c342c312c352c322c352c362c312c322c382c332c332c312c332c312c342c312c372c382c362c382c322c352c312c342c352c332c322c322c322c382c332c332c332c362c372c342c372c342c322c372c352c362c375d2c226d61785f626c6f636b5f6368616e67655f76696577223a36303030307d7df8fc7a1f6a856313c591a3a747f4eca7218a820b";
        let pub_key_list = x"1205041e0779f5c5ccb2612352fe4a200f99d3e7758e70ba53f607c59ff22a30f678ff757519efff911efc7ed326890a2752b9456cc0054f9b63215f1d616e574d6197120504468dd1899ed2d1cc2b829882a165a0ecb6a745af0c72eb2982d66b4311b4ef73cff28a6492b076445337d8037c6c7be4d3ec9c4dbe8d7dc65d458181de7b5250120504482acb6564b19b90653f6e9c806292e8aa83f78e7a9382a24a6efe41c0c06f39ef0a95ee60ad9213eb0be343b703dd32b12db32f098350cf3f4fc3bad6db23ce120504679930a42aaf3c69798ca8a3f12e134c019405818d783d11748e039de8515988754f348293c65055f0f1a9a5e895e4e7269739e243a661fff801941352c387121205048172918540b2b512eae1872a2a2e3a28d989c60d95dab8829ada7d7dd706d658df044eb93bbe698eff62156fc14d6d07b7aebfbc1a98ec4180b4346e67cc3fb01205048b8af6210ecfdcbcab22552ef8d8cf41c6f86f9cf9ab53d865741cfdb833f06b72fcc7e7d8b9e738b565edf42d8769fd161178432eadb2e446dd0a8785ba088f12050493421445b9421bd4cc90d7bc88c9301558047a76b20c59e7c511ee7d229982b142bbf593006e8099ad4a2e3a2a9067ce46b7d54bab4b8996e7abc3fcd8bf0a5f120504eb1baab602c5899282561cdaaa7aabbcdd0ccfcbc3e79793ac24acf90778f35a059fca7f73aeb60666178db8f704b58452b7a0b86219402c0770fcb52ac9828c";
        let sig_list = x"7d588d79ac9f0931c69150de6bfe5289f0147893781bffbcc32b5e07bd687d1048dda039ffc1e87de2e98610dc876e97411d604948473904b12b64bed8880bcc00ea8be33bb197c82690987e22e970221de11dfa019f470d784ef211edb6c9a3fd75bf74904adea08ed37a635c4dc58ccc21369afc1abcab4696a42be1097468a400289be668444122fd1d48c62781ded43e6fbda9bdd587dc7ee1bd326390d70e3f0e174fbd4854ed96c697dcee93feabbf7cdf290ebee93d4f5156d75d62b80ba301e79df9e679af49c403bbf05a24af2307adc96b641f4501fdb96e6704d27b2a87278e15bfee5909d4fa62dd45907cba23f833b3e96378d140d56722d1f59821e4006d8349493021e2cd6af96524357867b6be9d24ef33aaf66c430d5f91c33253304380ee17c6839fed964e7ba4910dd26533125b548cff6450140b10caec1b08fe01";
        CrossChainManager::change_book_keeper(&signer, &raw_header, &pub_key_list, &sig_list);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: alice
address alice = {{alice}};
script {
    use 0x1::Vector;
    use 0x18351d311d32201149a4df2a9fc2db8a::CrossChainRouter;

    fun test_verify_header_and_execute_tx(_signer: signer) {
        let proof_x = x"d020e91d858cba58b3dff91bf4b3adcacabf899e106ed6ad86a16a4a29e7817e307c080000000000000020b697330bd7a5850235f97d1bcd1c37739f4bc79a4f8e635dcb46ba45bc600ef4012f14f71b55ef55cedc91fd007f7a9ba386ec978f3aa80200000000000000144ddcf539d13e92d4151b7f5e607d4a09f725c47d06756e6c6f636b4a14000000000000000000000000000000000000000014344cfc3b8635f72f14200aaf2168d9f75df86fd36226100000000000000000000000000000000000000000000000000000000000";
        let block_header_x1 = x"000000009b91561700000000285c4b50cb092422c306eee00b18730bd1e05f0c144bc04d0adf1f44e0aef6c70000000000000000000000000000000000000000000000000000000000000000829ba7727b3bb7d42eff74342bafb37362b4898169750e8b2b8af2267c863ebf6fb8849a086fbed1ccd873b63642cce60ac54875cc3c1f054c1866e0bca5136dc90a185f5e4100007de0abdc2a5b63d5fd0c017b226c6561646572223a312c227672665f76616c7565223a224249703243555764736c424c6b34754979584174417949682f74685a6b5072445539566279697358754c574d6e634a775a49515161434f4b74724474793437454d3541554e4a7542523133546b6857616e56422b4b7a493d222c227672665f70726f6f66223a224a3830534c2b6c62433537306f64426374486f477a45504631516d506f7a4f4332323132553563796b4949346a6b77374d2f74746f317537386e4634347256433443676d344f786f71667943656b3568487132576a413d3d222c226c6173745f636f6e6669675f626c6f636b5f6e756d223a302c226e65775f636861696e5f636f6e666967223a6e756c6c7d0000000000000000000000000000000000000000";
        let header_proof_x = x"20c73c8b3c730086cfae83d735d2c405d6f5a00c3f1ff21ce91d223038d3c1ab4d000213149490394c2a8701af2dba1a303df05148a14092f6e59febca31eee4da660079807fe94ecb6f6d1b0b65be5f45159925a905bab8040af476c372ea0583dbba00b41a753c36f64bbe6d6fcd6c2ba40dc09c4c25b6b877bd363696fe1f62cbf6f700059195b0df4add4239eaef270bc187217dc872d11723d4fce02a3c2510461e5900f3c3d66c4611791ff1ebe8a2ef43f1cbf40876b637522c60a81f511445f8dc17011f86c65842afb760457d5ce8ad38821d2110331a7bbae87fe131a5e610f3a146004add0a7a5c74a56ce64a3555b4a73f367c414c80ecc15672dd86f7bff8bf65bc011daedaae87fc34d28ec3116dc04386c7c650f5db9e3a9a853c6e518821069bda001c6cf42ace3bf6b1a7e60ae29dc10aad67cdf672cdb083c601ee3996576cc2e401a1a8ab20062ebdcfa7a6e8f0c6c8b3de823920abd351eedc33d043de1c1449880171c734d6d77806f9475b69c8426bc5c09ce54c0b4ccb13df4315c62899e9926201f459d25426b21e5f2f6bdabf5e6a79f36002114b1ecc5cfa30a18cf3e4baf98d01ad42157822143a7be209b907901a31863d1b35ad9118c4c45d476e405872fb66017badaf21d00ca7e2a73c64dd7738ddcb6a881dcfb88ef0c171e33bfec529fe0a00e0a6008bab76556dbf47269adc41d6820c6a55982e9362257bfdf02a79ff5b8d01061cd147d032d11b1b7b6b5edc389f56d33f939e51be3c7949b357aac4e120df";
        let cur_raw_header = x"000000009b91561700000000f2e3823838bcdfafe08c6e9ff2cd1f86ae65dfc1052d15c9441aa6c07097015f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000051d45928d93800ffebc80373df7dbe735a2e9c5998b883e69494921fedbbe858057f1a5f5a8e0000216854be71737efbfd10017b226c6561646572223a362c227672665f76616c7565223a224244592f6c4875783448587341376f394962357877634a4d39727466656a454c786d6637766a48583574507a64724d356a47304a305265756d4338632f6e64725131306b4751622f50537a3255667a6267723430666a413d222c227672665f70726f6f66223a2242437877375a6d49446243476a3839576e715744564f6b714f7239645574344f4f2f777176366d4c3165656377474d542b3078664476544642614f3951534451437879725551344c316835392b3130486671386176673d3d222c226c6173745f636f6e6669675f626c6f636b5f6e756d223a33363433322c226e65775f636861696e5f636f6e666967223a6e756c6c7d0000000000000000000000000000000000000000";
        let signatures_x1 = x"6d905d095fc1b47eb30b8f176c94b01b64502790f3c20db2a5b7e555791bdbf8458a24c73c8f690ad8481e3754c3297991f9f4148d03316e2e5a6c6af9e7bbc900a81911a6eb529979ee021124c242a828657865fc7a899ab55fb7d2a1623341a67ae83c90a40bec8bf54fa3c5caad445062568d3c4c4099e84ad6c774e70d7d7d000b5d0a2ebc3685a6deeb96cfabf71e4a9d05606a5918e4765be6cc4cad38c3954e248d97b2fa378b954f323335c93298913c61048cf0b396467df1c6b6bbba4d01cd68657ad3c6d5a979093ff1345eefb269e86498b519418fa0e5e756ce01a9b939d46b405d2a167883bda0a40023cce39659890c97a59e3f772b6fc3c2e03221004d425ad3bfef2de8b1d523cbfd754d4ea2c8e8fa5f6904b0389f4e5d62039083454e2a24da6e1c90334fd760eaa1921bdac10158758f682cb401e1df16ee0ec801b8e8eb23200a1571c6ad516528ce3f1280506eed9f1e380b9a5e770f1e89d8414182c7b83dc8f230d288c4745d0a8102cfc015d422af77d139bc606054363ecf0138fc63be97c354539b517bd8abd97d86fa3484894663aa7dcf578cfad7368df577206e28daf800cba179314f34f1a6dec569ff12e15c22b598028cce64bfa54601";

        let root_hash = x"0000000000000000000000000000000000000000000000000000000000000000";
        let proof_leaf = Vector::empty<u8>();
        let proof_siblings = Vector::empty<u8>();

        CrossChainRouter::verify_header_and_execute_tx(
            &proof_x,
            &block_header_x1,
            &header_proof_x,
            &cur_raw_header,
            &signatures_x1,
            &root_hash,
            &proof_leaf,
            &proof_siblings);
    }
}
// check: "Keep(ABORTED { code: 27137"
// TODO: must set a correct native address


