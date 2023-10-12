1. Add the following items to your qb-core/shared/items.lua

['raw_beef'] = {['name'] = 'raw_beef', ['label'] = 'Raw Beef', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'raw_beef.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Eat More Chicken!'},
['raw_chicken'] = {['name'] = 'raw_chicken', ['label'] = 'Raw Chicken', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'raw_chicken.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Not affiliated with Chick Fil A'},
['raw_pork'] = {['name'] = 'raw_pork', ['label'] = 'Raw Pork', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'raw_pork.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Right off the pig!'},
['steak'] = {['name'] = 'steak', ['label'] = 'Steak', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'steak.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Right from Michelle MooMoo.'},
['chicken'] = {['name'] = 'chicken', ['label'] = 'Chicken', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'chicken.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Mmmm. Birdy!'},
['pork'] = {['name'] = 'pork', ['label'] = 'Pork', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'pork.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Cook it up real good!'},

2. Copy the images from the /images/ folder to qb-inventory/html/images

3. Add the following job to qb-core/shared/jobs.lua

['slaughter'] = {
    label = 'Slaughter House',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Employee',
            payment = 30
        },
        ['1'] = {
            name = 'Boss',
            payment = 60,
            isboss = true
        },
    },
},

4. OPTIONAL: Add the following job to qb-cityhall/config.lua

["slaughter"] = {["label"] = "Slaughter House", ["isManaged"] = false},