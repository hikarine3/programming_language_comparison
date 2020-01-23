const value = `This is target 1.
Name is apple.
Target 2 is here. 
Name is orange.`
if (matches = [...value.matchAll(/target\s([\d+]).*?Name\s+is\s+([^\.]+)\./sig)] ) {
    for (match of matches) {
        console.log(match[1]+"="+match[2]);
    }
}