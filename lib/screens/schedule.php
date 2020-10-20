<?php
class Schedular
{

    public function checkDueDate($date)
    {
        global $conn;

        $query = "SELECT videoUrl FROM videos WHERE videoDueDate =$date";
        $query_sql = mysqli_query($conn, $query);

        while ($row = mysqli_fetch_array($query_sql)) {

            $dueDate = $row['date_due'];
            $scheduledDate = date("Y-m-d", strtotime(date("Y-m-d", strtotime($dueDate))));


            if (date("Y-m-d") == $scheduledDate) {
                return $row['videoUrl'];
            } else {
                return 'Not yet time';
            }
        }
    }
}
