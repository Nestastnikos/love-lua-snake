Queue = {}
function Queue.new ()
    return {first = 0, last = -1}
end

function Queue.pushright(queue, value)
    local last = queue.last + 1
    queue.last = last
    queue[last] = value
end

function Queue.is_empty(queue)
    return queue.first > queue.last
end

function Queue.popleft (queue)
    if Queue.is_empty(queue) then
        error("queue is empty")
    end

    local first = queue.first
    local value = queue[first]
    queue[first] = nil        -- to allow garbage collection
    queue.first = first + 1
    return value
end