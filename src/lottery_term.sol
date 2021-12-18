//SPDX-License-Identifier: UNLICENSED

pragma solidity >= 0.4.22;

contract Lottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    //관리자만 가능
    modifier restricted() {
        require(msg.sender == manager);
        _; //All the replace code include
    }

    function join_the_game() public payable {
        // 1000 wei 이상 판돈을 건사람만 참가
        require(msg.value >= 1000 wei );

        // 참가자 추가
        players.push(msg.sender);
    }

    // 관리자만 추첨 수행
    function pick_the_Winner() public restricted {

        // 타임 스탬프 난수를 이용한 플레이어 선택
        uint index = block.timestamp % players.length;

        // 복권당첨된 선택된 플레이어에게 잔고 전달
        payable(players[index]).transfer(address(this).balance);

        // 당첨금 전달 후 플레이어 초기화
        players = new address[](0); //new array basic size is 0!!

    }

    // 플레이어들 주소 얻기
    function getPlayers() public view returns (address[] memory){
        return players;
    }

    // 메니저 주소 얻기
    function getManager() public view returns (address){
        return manager;
    }

    // 상금 얻기
    function getPrice() public view returns (uint){
        return address(this).balance;
    }

}