pragma solidity ^0.8.2;

contract ManageMedicalRecords {
    struct manager {
        string name;
        bool admin;
    }
    mapping(address => manager) isManager;

    constructor() {
        isManager[msg.sender] = manager("Admin", true);
    }

    function addManager(address acc, string memory name) public {
        require(isManager[acc].admin);
        bytes memory _name = bytes(name);

        require(_name.length != 0);

        isManager[acc] = manager(name, true);
    }

    function findManage(address acc) public view returns (
            address _acc,
            string memory name,
            bool admin
        )
    {
        manager storage res = isManager[acc];
        return (acc, res.name, res.admin);
    }

    struct Patient {
        string id;
        string name;
        uint256 age;
        string gender;
        string add;
        string phone;
        string major;
    }
    mapping(string => Patient) isPatient;
    struct MedicalHistory {
        string inforMH; //Thong tin
        string symptoms; //Trieu chung
        string medicalCond; //Tinh trang benh
        string testRes; //Ket qua xet nghiem
        string diagnosis; //Chan doan
    }
    struct InforTreatment {
        string medications; //Cac loai thuoc
        string dosages; //lieu luong
        string treatments; //pp dieu tri
        string duration; //Thoi gian dieu tri
    }
    struct MedicalRecord {
        Patient patient;
        MedicalHistory medicalHistory;
        InforTreatment inforTreat;
    }

    function addPatient(
        string memory _id,
        string memory _name,
        uint256 _age,
        string memory _gender,
        string memory _add,
        string memory _phone,
        string memory _major
    ) public {
        require((bytes(isPatient[_id].id).length) == 0, "Patient is exist");
        isPatient[_id] = Patient(
            _id,
            _name,
            _age,
            _gender,
            _add,
            _phone,
            _major
        );
    }

    function findPatent(string memory _id) public view returns (
            string memory id,
            string memory name,
            uint256 age,
            string memory gender,
            string memory add,
            string memory phone,
            string memory major
        )
    {
        Patient storage res = isPatient[_id];
        return (
            res.id,
            res.name,
            res.age,
            res.gender,
            res.add,
            res.phone,
            res.major
        );
    }

    function changeInforPatient(
        address _acc,
        string memory _id,
        string memory _name,
        uint256 _age,
        string memory _gender,
        string memory _add,
        string memory _phone,
        string memory _major
     ) public {
        require((bytes(isPatient[_id].id).length) != 0, "Patient is not exist");

        require ((bytes(isManager[_acc].name).length) != 0, "User is not manager");
        Patient storage res = isPatient[_id];
        res.name = _name;
        res.age = _age;
        res.gender = _gender;
        res.add = _add;
        res.phone = _phone;
        res.major = _major;
    }

    function randomString(uint256 length) internal view returns (string memory) {
    bytes memory characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    bytes memory result = new bytes(length);
    uint256 charLength = characters.length;

    for (uint256 i = 0; i < length; i++) {
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, i)));
        result[i] = characters[rand % charLength];
    }

    return string(result);
    }
    

    function addDataRandom(uint256 number) public view returns(string [] memory){
        string[] memory myArray;
        for(uint256 i = 0 ;i<number; i++){
            myArray[i]=randomString(4);
        }
        return myArray;
    }


    
}
