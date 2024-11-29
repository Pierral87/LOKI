<table class="table table-bordered table-striped">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($data as $user) :  ?>
            <tr>
                <td><?= $user['id'] ?></td>
                <td><?= $user['nom'] ?></td>
                <td><?= $user['email'] ?></td>
                <td>
                    <a href="2-exoUser.php?action=voir&id=<?= $user['id'] ?>" class="btn btn-info">Voir</a>
                    <a href="2-exoUser.php?action=modifier&id=<?= $user['id'] ?>" class="btn btn-warning">Modifier</a>
                    <a href="2-exoUser.php?action=supprimer&id=<?= $user['id'] ?>" class="btn btn-danger">Supprimer</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>