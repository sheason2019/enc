/*
  Warnings:

  - You are about to drop the column `snapshot` on the `GroupMembers` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_GroupMembers" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "groupID" INTEGER NOT NULL,
    "signPubkey" TEXT NOT NULL,
    CONSTRAINT "GroupMembers_groupID_fkey" FOREIGN KEY ("groupID") REFERENCES "Group" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_GroupMembers" ("groupID", "id", "signPubkey") SELECT "groupID", "id", "signPubkey" FROM "GroupMembers";
DROP TABLE "GroupMembers";
ALTER TABLE "new_GroupMembers" RENAME TO "GroupMembers";
CREATE INDEX "GroupMembers_groupID_signPubkey_idx" ON "GroupMembers"("groupID", "signPubkey");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
