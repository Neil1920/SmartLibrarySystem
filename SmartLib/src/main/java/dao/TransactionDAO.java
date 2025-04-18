package dao;

import model.Transaction;
import model.User;
import model.Book;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    public List<Transaction> getAllTransactions() {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT * FROM transactions";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            UserDAO userDAO = new UserDAO();
            BookDAO bookDAO = new BookDAO();

            while (rs.next()) {
                int userId = rs.getInt("user_id");
                int bookId = rs.getInt("book_id");

                User user = userDAO.getUserById(userId);
                Book book = bookDAO.getBookById(bookId);

                Transaction txn = new Transaction(
                    rs.getInt("transaction_id"),
                    user,
                    book,
                    rs.getDate("borrow_date"),
                    rs.getDate("due_date"),
                    rs.getDate("return_date"),
                    rs.getString("status")
                );

                list.add(txn);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean recordTransaction(Transaction txn) {
        String sql = "INSERT INTO transactions (user_id, book_id, borrow_date, due_date, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, txn.getUser().getUserId());
            ps.setInt(2, txn.getBook().getBookId());
            ps.setDate(3, txn.getBorrowDate());
            ps.setDate(4, txn.getDueDate());
            ps.setString(5, txn.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int txnId, String status) {
        String sql = "UPDATE transactions SET status = ? WHERE transaction_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, txnId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Add this method to fix the error
    public boolean markReturned(int transactionId, Date returnDate) {
        String sql = "UPDATE transactions SET return_date = ?, status = 'returned' WHERE transaction_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, returnDate);
            ps.setInt(2, transactionId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
