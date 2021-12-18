//SPDX-License-Identifier: UNLICENSED

pragma solidity >= 0.4.22;

contract Lottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    //�����ڸ� ����
    modifier restricted() {
        require(msg.sender == manager);
        _; //All the replace code include
    }

    function join_the_game() public payable {
        // 1000 wei �̻� �ǵ��� �ǻ���� ����
        require(msg.value >= 1000 wei );

        // ������ �߰�
        players.push(msg.sender);
    }

    // �����ڸ� ��÷ ����
    function pick_the_Winner() public restricted {

        // Ÿ�� ������ ������ �̿��� �÷��̾� ����
        uint index = block.timestamp % players.length;

        // ���Ǵ�÷�� ���õ� �÷��̾�� �ܰ� ����
        payable(players[index]).transfer(address(this).balance);

        // ��÷�� ���� �� �÷��̾� �ʱ�ȭ
        players = new address[](0); //new array basic size is 0!!

    }

    // �÷��̾�� �ּ� ���
    function getPlayers() public view returns (address[] memory){
        return players;
    }

    // �޴��� �ּ� ���
    function getManager() public view returns (address){
        return manager;
    }

    // ��� ���
    function getPrice() public view returns (uint){
        return address(this).balance;
    }

}