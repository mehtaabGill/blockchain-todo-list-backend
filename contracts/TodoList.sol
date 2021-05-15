// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

/**
  * @title Todo List
  * @author Mehtaab Gill
  */
contract TodoList {

    // main map for storing all todo entries
    mapping (address => TodoEntry[]) todoEntries;
    
    // running count of todo entires
    int256 public TodoCount = 0;

    struct TodoEntry {
        string content;
        bool completed;
        uint256 timestamp;
        int256 ID;
    }

    event TodoAdded(
        string content,
        address owner,
        int256 ID
    );

  /**
    * @notice Add a new todo entry
    * @param _content The content of the todo
    * @return todo The TodoEntry which has been created
    */
    function addTodoEntry(string memory _content) public returns (TodoEntry memory todo) {
        todo = TodoEntry(_content, false, block.timestamp, TodoCount++);
        todoEntries[msg.sender].push(todo);
        emit TodoAdded(_content, msg.sender, TodoCount);
    }

  /**
    * @notice Fetch all todo entries of the message sender
    * @return The array of TodoEntry
    */
    function fetchTodoEntries() public view returns (TodoEntry[] memory) {
        return todoEntries[msg.sender];
    }

  /**
    * @notice Fetch a specific TodoEntry by ID
    * @param _ID The ID of the TodoEntry to be fetched
    * @return TodoEntry The TodoEntry of the corresponding owner + ID
    */
    function fetchTodoEntryByID(int _ID) public view returns (TodoEntry memory) {
        for (uint256 i = 0; i < todoEntries[msg.sender].length; i++) {
            if(todoEntries[msg.sender][i].ID == _ID) {
                return todoEntries[msg.sender][i];
            }
        }

        revert();
    }

  /**
    * @notice Fetch all todo entries of the message sender
    * @param _ID The ID of the TodoEntry to toggle the completion for
    * @return TodoEntry The updated TodoEntry
    */
    function toggleTodoCompletion(int _ID) public returns (TodoEntry memory) {
        for (uint256 i = 0; i < todoEntries[msg.sender].length; i++) {
            if(todoEntries[msg.sender][i].ID == _ID) {
                todoEntries[msg.sender][i].completed = !todoEntries[msg.sender][i].completed;
                return todoEntries[msg.sender][i];
            }
        }

        revert();
    }
}