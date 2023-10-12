Config = {}
Config.CoreName = "qb-core"
Config.TargetName = "qb-target"
Config.JobName = "slaughter"
Config.SellFood = {
    Blip = {
        Coords = vector3(-762.02, -600.8, 30.28),
        Sprite = 276,
        Color = 6,
        Scale = 0.85,
        Name = "Sell Meat"
    },
    Ped = {
        Coords = vector4(-762.01, -600.78, 29.28, 333.92),
        Model = 'a_m_y_beach_03'
    },
    Target = {
        Coords = vector3(-761.99, -600.7, 30.28),
        Heading = 145,
    },
    Items = {
        { MenuText = 'Sell Steak', Item = 'steak', SellPrice = 50 },
        { MenuText = 'Sell Chicken', Item = 'chicken', SellPrice = 60 },
        { MenuText = 'Sell Pork', Item = 'pork', SellPrice = 45 },
    }
}
Config.Cooker = {
    Blip = {
        Coords = vector3(-86.54, 6233.18, 30.64),
        Sprite = 436,
        Color = 1,
        Scale = 0.65,
        Name = "Cook Meat"
    },
    Target = {
        Coords = vector3(-86.54, 6233.18, 30.64),
        Heading = 120
    },
    Items = {
        { MenuText = 'Cook Beef', Raw = 'raw_beef', Cooked = 'steak' },
        { MenuText = 'Cook Chicken', Raw = 'raw_chicken', Cooked = 'chicken' },
        { MenuText = 'Cook Pork', Raw = 'raw_pork', Cooked = 'pork' },
    }
}
Config.AnimalSpawns = {
    {
        Blip = {
            Coords = vector3(2175.65, 4967.8, 41.33),
            Sprite = 141,
            Color = 23,
            Scale = 0.65,
            Name = "Pig Hunting"
        },
        EntityModel = 'a_c_pig',
        SpawnLocation = vector3(2175.65, 4967.8, 40.32),
        Item = { Name = 'raw_pork', AmountMin = 1, AmountMax = 3 } ,
    },
    {
        Blip = {
            Coords = vector3(1415.17, 1076.72, 113.33),
            Sprite = 141,
            Color = 21,
            Scale = 0.65,
            Name = "Cow Hunting"
        },
        EntityModel = 'a_c_cow',
        SpawnLocation = vector3(1415.17, 1076.72, 113.33),
        Item = { Name = 'raw_beef', AmountMin = 1, AmountMax = 3 } ,
    },
    {
        Blip = {
            Coords = vector3(1581.58, 2168.11, 79.27),
            Sprite = 141,
            Color = 0,
            Scale = 0.65,
            Name = "Chicken Hunting"
        },
        EntityModel = 'a_c_hen',
        SpawnLocation = vector3(1581.58, 2168.11, 78.27),
        Item = { Name = 'raw_chicken', AmountMin = 1, AmountMax = 2 } ,
    }
}