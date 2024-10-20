pragma solidity ^0.4.15;
import "./Factory.sol";
import "./Multisigwallet.sol";
import "./Security.sol";

/// @title Multisignature wallet factory - Allows creation of multisig wallet.
/// @author Stefan George - <stefan.george@consensys.net>
contract MultiSigWalletFactory is Factory {
    Security public security;  // Reference the security contract

    // Constructor passes the address of the Security contract to the base contract
    constructor(address _securityContract) Factory(_securityContract) {}

    // Modifier to ensure only authorized addresses can approve a transaction
    modifier onlyAuthorized() {
        require(security.isAuthorized(msg.sender), "Not authorized");
        _;
    }

    // Function to approve a multisig transaction, only accessible by authorized users
    function approveTransaction() public onlyAuthorized {
        // Your multisig logic here
    }

    /*
     * Public functions
     */
    /// @dev Allows verified creation of multisignature wallet.
    /// @param _owners List of initial owners.
    /// @param _required Number of required confirmations.
    /// @return Returns wallet address.
    function create(address[] _owners, uint _required)
        public
        returns (address wallet)
    {
        wallet = new MultiSigWallet(_owners, _required);
        register(wallet);
    }
}
