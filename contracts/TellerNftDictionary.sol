// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//pragma experimental ABIEncoderV2;

// Contracts
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

// Libraries
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// Interfaces
import "./ITellerNFT.sol";
import "./IStakeableNFT.sol";

/**
 * @notice This contract is used by borrowers to call Dapp functions (using delegate calls).
 * @notice This contract should only be constructed using it's upgradeable Proxy contract.
 * @notice In order to call a Dapp function, the Dapp must be added in the DappRegistry instance.
 *
 * @author develop@teller.finance
 */
contract TellerNFTDictionary is  IStakeableNFT, ERC721Upgradeable, AccessControlUpgradeable  {
    using Counters for Counters.Counter;
    using EnumerableSet for EnumerableSet.UintSet;
    using SafeMath for uint256;

     struct Tier {
        uint256 baseLoanSize;
        string[] hashes;
        address contributionAsset;
        uint256 contributionSize;
        uint8 contributionMultiplier;
    }

    /* Constants */

    bytes32 public constant ADMIN = keccak256("ADMIN");
 

    //The address of the deployed Teller NFT V1 
    address public tellerNFTAddress; 

    /* State Variables */

    // It holds the total number of tiers.
    Counters.Counter internal _tierCounter;

    // It holds the total number of tokens minted.
    Counters.Counter internal _tokenCounter;

    // It holds the information about a tier.
    mapping(uint256 => Tier) internal _tiers;

    // It holds which tier a token ID is in.
    mapping(uint256 => uint256) internal _tokenTier;

    // It holds a set of token IDs for an owner address.
    //mapping(address => EnumerableSet.UintSet) internal _ownerTokenIDs;

    // Link to the contract metadata
    //string private _metadataBaseURI;

    // Hash to the contract metadata located on the {_metadataBaseURI}
    //string private _contractURIHash;

    /* Modifiers */

    modifier onlyAdmin() {
        require(hasRole(ADMIN, _msgSender()), "TellerNFT: not admin");
        _;
    }

    constructor(){        
      _setupRole(ADMIN, msg.sender );
    }


   

    /* External Functions */

    /**
     * @notice It returns information about a Tier for a token ID.
     * @param index Tier index to get info.
     */
    function getTier(uint256 index)
        external
        view
         
        returns (Tier memory tier_)
    {
        tier_ = _tiers[index];
    }

    /**
     * @notice It returns information about a Tier for a token ID.
     * @param tokenId ID of the token to get Tier info.
     */
    function getTokenTier(uint256 tokenId)
        external
        view
         
        returns (uint256 index_, Tier memory tier_)
    {
        index_ = _tokenTier[tokenId];
        tier_ = _tiers[index_];
    }

    /**
     * @notice It returns an array of token IDs owned by an address.
     * @dev It uses a EnumerableSet to store values and loops over each element to add to the array.
     * @dev Can be costly if calling within a contract for address with many tokens.
     */
    function getTierHashes(uint256 tierIndex)
        external
        view
         
        returns (string[] memory hashes_)
    {
        hashes_ = _tiers[tierIndex].hashes;
    }

    
  

    /**
     * @notice Adds a new Tier to be minted with the given information.
     * @dev It auto increments the index of the next tier to add.
     * @param newTier Information about the new tier to add.
     *
     * Requirements:
     *  - Caller must have the {MINTER} role
     */
    function addTier(Tier memory newTier) external   onlyAdmin {
        Tier storage tier = _tiers[_tierCounter.current()];

        tier.baseLoanSize = newTier.baseLoanSize;
        tier.hashes = newTier.hashes;
        tier.contributionAsset = newTier.contributionAsset;
        tier.contributionSize = newTier.contributionSize;
        tier.contributionMultiplier = newTier.contributionMultiplier;

        _tierCounter.increment();
    }

     

     
  /*  function initialize(address[] calldata minters)
        external
        override
        initializer
    {
        //__ERC721_init("Teller NFT", "TNFT");
        __AccessControl_init();

        for (uint256 i; i < minters.length; i++) {
            _setupRole(MINTER, minters[i]);
        }

        //_metadataBaseURI = "https://gateway.pinata.cloud/ipfs/";
        //_contractURIHash = "QmWAfQFFwptzRUCdF2cBFJhcB2gfHJMd7TQt64dZUysk3R";
    }*/

    function setTellerNFTAddress(address addr)
     external
     onlyAdmin
     returns (bool)
    {
        tellerNFTAddress = addr;
        return true;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(AccessControlUpgradeable, ERC721Upgradeable)
        returns (bool)
    {
        return
            interfaceId == type(ITellerNFT).interfaceId ||
            ERC721Upgradeable.supportsInterface(interfaceId) ||
            AccessControlUpgradeable.supportsInterface(interfaceId);
    }

    /**
     * @notice It returns the hash to use for the token URI.
     */
    function _tokenURIHash(uint256 tokenId)
        internal
        view
        returns (string memory)
    {
        string[] storage tierImageHashes = _tiers[_tokenTier[tokenId]].hashes;
        return tierImageHashes[tokenId.mod(tierImageHashes.length)];
    }

   
    
    function _msgData() internal pure override returns (bytes calldata) {
        return msg.data;
    }

    




    /**
        New methods for the dictionary
    */

    /**
     * @notice It returns information about a Tier for a token ID.
     * @param tokenId ID of the token to get Tier info.
     */
    function tokenBaseLoanSize(uint256 tokenId)
        public
        view    
        override   
        returns (uint256)
    {  
        return _tiers[_tokenTier[tokenId]].baseLoanSize;
    }

    /**
     * @notice It returns information about a Tier for a token ID.
     * @param tokenId ID of the token to get Tier info.
     */
    function tokenURIHash(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string[] storage tierImageHashes = _tiers[_tokenTier[tokenId]].hashes;
        return tierImageHashes[tokenId.mod(tierImageHashes.length)];
    }

    /**
     * @notice It returns information about a Tier for a token ID.
     * @param tokenId ID of the token to get Tier info.
     */
    function tokenContributionAsset(uint256 tokenId)
        public
        view  
        override     
        returns (address)
    {  
        return _tiers[_tokenTier[tokenId]].contributionAsset;
    }

    /**
     * @notice It returns information about a Tier for a token ID.
     * @param tokenId ID of the token to get Tier info.
     */
    function tokenContributionSize(uint256 tokenId)
        public
        view   
        override    
        returns (uint256)
    {  
        return _tiers[_tokenTier[tokenId]].contributionSize;
    }

    /**
     * @notice It returns information about a Tier for a token ID.
     * @param tokenId ID of the token to get Tier info.
     */
    function tokenContributionMultiplier(uint256 tokenId)
        public
        view    
        override   
        returns (uint256)
    {  
        return _tiers[_tokenTier[tokenId]].contributionMultiplier;
    }


}
