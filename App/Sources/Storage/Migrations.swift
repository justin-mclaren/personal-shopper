import GRDB

let migrator: DatabaseMigrator = {
    var migrator = DatabaseMigrator()

    migrator.registerMigration("v1_initial") { db in
        try db.create(table: "profiles") { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("name", .text).notNull()
            table.column("created_at", .datetime).notNull()
        }

        try db.create(table: "preferences") { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("profile_id", .integer).indexed().references("profiles")
            table.column("key", .text).notNull()
            table.column("value", .text).notNull()
        }

        try db.create(table: "products") { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("host", .text).indexed()
            table.column("url", .text).unique(onConflict: .ignore)
            table.column("title", .text)
            table.column("price_cents", .integer)
            table.column("meta_json", .text)
        }

        try db.create(table: "vectors") { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("product_id", .integer).indexed().references("products")
            table.column("dim", .integer).notNull()
            table.column("vec", .blob).notNull()
        }
    }

    return migrator
}()
