const TodoList = artifacts.require('TodoList');
let TodoID, DefaultInstance;

contract('TodoList', accounts => {
    const defaultTodo = 'do something cool!';

    it('starts with a default todo list length of 0', async () => {
        DefaultInstance = await TodoList.deployed();
        
        const todoCount = await DefaultInstance.TodoCount();
        
        assert.equal(todoCount, 0);
    })

    it('adds the TODO', async () => {        
        await DefaultInstance.addTodoEntry(defaultTodo);
        
        const todos = await DefaultInstance.fetchTodoEntries();
        
        assert.equal(todos.length, 1);
        assert.equal(todos[0].content, defaultTodo);
        assert.equal(todos[0].completed, false);

        TodoID = todos[0].ID;
    })

    it('modifies the TODO', async () => {
        const updatedTodo = await DefaultInstance.toggleTodoCompletion(TodoID);

        assert.equal(updatedTodo.completed, true);
    })
})