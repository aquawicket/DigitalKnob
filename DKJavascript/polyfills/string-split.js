const split = (string, delimiter) => {
    const res = []
    if (delimiter === '') return Array.from(string)
    const startSplit = (str, i) => {
        if (i >= string.length) return
        const index = str.indexOf(delimiter)
        if (index >= 0) {
            res.push(str.substring(0, index))
            startSplit(str.substring(index + delimiter.length), index + delimiter.length)
        } else {
            res.push(str)
        }
    }
    startSplit(string, 0)
    return res
}