// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract YunaNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;
    Counters.Counter private _tokenIds;
    mapping(uint256 => address) private _owners;
    // Base URI for metadata
    string private _baseTokenURI;

    // Mapping for on-chain image storage
    mapping(uint256 => string) private _tokenImages;
    
    constructor()
    ERC721("YunaNFT", "YNFT")
    Ownable(msg.sender)
    {}
    // Method 1: Mint with IPFS image (recommended for larger images)
    function mintWithIPFS(
        address recipient, 
        string memory imageURI,
        string memory name,
        string memory description
    ) public onlyOwner returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        // Create the metadata JSON
        string memory metadata = string(
            abi.encodePacked(
                '{"name": "', name, '",',
                '"description": "', description, '",',
                '"image": "', imageURI, '"}'
            )
        );

        // Convert to base64
        string memory encodedMetadata = Base64.encode(bytes(metadata));
        string memory tokenURI = string(abi.encodePacked("data:application/json;base64,", encodedMetadata));

        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        return newTokenId;
    }

    // Method 2: Mint with on-chain base64 image (good for small pixel art)
    function mintWithBase64(
        address recipient,
        string memory base64Image, // Must include data:image/png;base64, prefix
        string memory name,
        string memory description
    ) public onlyOwner returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        // Store the image
        _tokenImages[newTokenId] = base64Image;

        // Create the metadata JSON
        string memory metadata = string(
            abi.encodePacked(
                '{"name": "', name, '",',
                '"description": "', description, '",',
                '"image": "', base64Image, '"}'
            )
        );

        // Convert to base64
        string memory encodedMetadata = Base64.encode(bytes(metadata));
        string memory tokenURI = string(abi.encodePacked("data:application/json;base64,", encodedMetadata));

        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        return newTokenId;
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        return _owners[tokenId] != address(0);
    }
    
    function getTokenImage(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenImages[tokenId];
    }

    /**
     * @dev Returns the total number of tokens minted
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }
}
